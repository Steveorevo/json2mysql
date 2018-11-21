<?php
/**
 * JSON2MySQL Class and command line tool.
 */

require_once( __DIR__ . '/../vendor/autoload.php' );
class JSON2MySQL {
  public $version = "1.0.0"; // TODO: obtain via composer
  public $climate = NULL;
  public $jsonDB = NULL;
  public $dbNames = [];
  public $db;

  /**
   * Create our JSON2MySQL object
   */
  function __construct() {
 
  }

  /**
   * Process the command line interface arguments
   */
  function cli() {
    $composer = json_decode(file_get_contents(__DIR__ . "/../composer.json"));
    $this->climate = new League\CLImate\CLImate;
    $this->climate->description( $composer->description . "\nVersion " . $this->version);
    $this->climate->arguments->add([
      'help' => [
        'prefix'       => '?',
        'longPrefix'   => 'help',
        'description'  => 'print this help',
        'noValue'      => true,
      ],
      'host' => [
        'prefix'       => 'h',
        'longPrefix'   => 'hose',
        'description'  => 'host name or IP address (default: localhost)',
        'defaultValue' => 'localhost',
      ],
      'list' => [
        'prefix'      => 'l',
        'longPrefix'  => 'list',
        'description' => 'list tables available for import',
        'noValue'     => true,
      ],
      'password' => [
        'prefix'       => 'p',
        'longPrefix'   => 'password',
        'description'  => 'password to connect with (default is none)',
        'defaultValue' => '',
      ],
      'port' => [
        'prefix'      => 'P',
        'longPrefix'  => 'port',
        'description' => 'the TCP/IP port number to connect to',
        'castTo'      => 'int',
      ],
      'tables' => [
        'prefix'       => 't',
        'longPrefix'   => 'tables',
        'description'  => 'a comma delimited list of tables (default empty for all)',
        'defaultValue' => '',
      ],
      'user' => [
        'prefix'       => 'u',
        'longPrefix'   => 'user',
        'description'  => 'username to connect as (default: root)',
        'defaultValue' => 'root',
      ],
      'quiet' => [
        'prefix'       => 'q',
        'longPrefix'   => 'quiet',
        'description'  => 'quiet (no output and default question to yes)',
        'noValue'      => true
      ],
      'version' => [
        'prefix'       => 'v',
        'longPrefix'   => 'version',
        'description'  => 'output version number',
        'noValue'      => true,
      ],
      'json_file' => [
        'description'  => 'the json file to import'
      ]
    ]);
    $this->climate->arguments->parse();
    if (! $this->climate->arguments->defined("help")) {
      $this->showVersion();
      $this->doListing();
      $this->importJSON();  
    }
    $this->climate->usage();
  }

  /**
   * Import a JSON representation of the given database and tables
   */
  function importJSON() {
    $this->parseJSONFile();
    $this->getDBNames();

    // Prompt for database overwrite
    if (! $this->climate->arguments->defined('quiet')) {
      if (FALSE !== in_array($this->jsonDB->name, $this->dbNames)) {
        $input = $this->climate->confirm("Database " . $this->jsonDB->name . " exists. Overwrite (destroy) existing?");
        if (!$input->confirmed()) {
            exit();
        }
      }
    }

    // Create (drop any existing) database definition
    $this->connectToDB();
    $sql = "DROP DATABASE IF EXISTS `" . $this->jsonDB->name . "`;\n";
    if ($this->db->query($sql) !== TRUE) {
        echo "Error, dropping database: " . $this->db->error;
        exit();
    }
    $sql = $this->jsonDB->create . ";\n";
    if ($this->db->query($sql) !== TRUE) {
      echo "Error, creating database: " . $this->db->error;
      exit();
    }else{
      $sql = "USE `" . $this->jsonDB->name . "`;\n";
      if ($this->db->query($sql) !== TRUE) {
        echo "Error, using database: " . $this->db->error;
        exit();
      }
    }

    // Create tables and import data
    foreach($this->jsonDB->tables as $table) {

      // Check for implicit tables or default to all
      $bSkip = false;
      if ($this->climate->arguments->defined('tables')) {
        $t = ',' . $this->climate->arguments->get('tables') . ',';
        if (FALSE === strpos($t, "," . $table->name . ",")) {
          $bSkip = true;
        }
      }
      if (FALSE === $bSkip) {
        $sql = $table->create;
        if ($this->db->query($sql) !== TRUE) {
          echo "Error, creating table: " . $this->db->error;
          exit();
        }
  
        // Import data
        $last = round(microtime(true) * 1000);
        $spin = 0;
        foreach($table->data as $row) {
          $sql = "INSERT INTO $table->name (";
          $vals = "(";
          foreach($table->columns as $col) {
            $sql = $sql . $col->name . ',';
            $v = $row->{$col->name};
            if (NULL !== $v) {
              if ($col->json_type === 'string') {
                if (is_object($v) || is_array($v)) {
                  $vals = $vals . '"' . str_replace("\r", '\r', str_replace("\n", '\n', addslashes(serialize($v)))) . '",';
                }else{
                  $vals = $vals . '"' . str_replace("\r", '\r', str_replace("\n", '\n', addslashes($v))) . '",';
                }
              }else{
                if ($col->json_type === 'number') {
                  $vals = $vals . strval($v) . ',';
                }else{
                  if ($v) { // Boolean
                    $vals = $vals . 'true' . ',';
                  }else{
                    $vals = $vals . 'false' . ',';
                  }
                }
              }
            }else{
              $vals = $vals . 'NULL' . ',';
            }
          }
          $sql = new Steveorevo\GString($sql);
          $sql = $sql->delRightMost(",")->concat(") VALUES " . $vals);
          $sql = $sql->delRightMost(",")->concat(");\n");
          if ($this->db->query($sql) !== TRUE) {
            echo "Error, insert into table: " . $table->name . "\n";
            echo $sql . "\n";
            exit();
          }
          if (! $this->climate->arguments->defined('quiet')) {
  
            // Spin the cursor
            if ((round(microtime(true) * 1000) - 100) > $last) {
              $last = round(microtime(true) * 1000);
              echo chr(8);
              if ($spin == 0 || $spin == 4) {
                echo "|";
              } elseif ($spin == 1 || $spin == 5) {
                echo "/";
              } elseif ($spin == 2 || $spin == 6) {
                echo "-";
              } elseif ($spin == 3 || $spin == 7) {
                echo "\\";
              }
              if ($spin > 6) {
                $spin = 0;
              }else{
                $spin++;
              }
            }
          }
        }
        if (! $this->climate->arguments->defined('quiet')) {
          echo chr(8) . "Imported table: " . $table->name . "\n";
        }       
      }
    }
    if (! $this->climate->arguments->defined('quiet')) {
      echo chr(8) . "Database import complete: " . $this->jsonDB->name . "\n";
    }
    $this->db->close();
    exit();
  }

  //   $database = $this->climate->arguments->get('database');
  //   if (FALSE == in_array($database, $this->dbNames)) {
  //     if ($database == NULL) {
  //       echo "Missing database name.\nType 'mysql2json --help' for more options.\n";
  //     }else{
  //       echo "Unknown database: $database\n";
  //     }
  //     exit();
  //   }

  //   // Define the creation for databases and tables
  //   $this->getTables();
  //   $this->connectToDB($database);
  //   $objDB = new stdClass();
  //   $objDB->name = $database;
  //   $r = $this->db->query("SHOW CREATE DATABASE $database;");
  //   if ($r->num_rows > 0) {
  //     $row = $r->fetch_assoc();
  //     $objDB->create = $row["Create Database"];
  //   }
  //   $objDB->tables = [];
  //   foreach($this->tables as $name) {
  //     $r = $this->db->query("SHOW CREATE TABLE $name;");
  //     if ($r->num_rows > 0) {
  //       $row = $r->fetch_assoc();
  //       $table = new stdClass();
  //       $table->name = $name;
  //       $table->create = $row["Create Table"];
  //       $table->columns = [];
  //       $table->data = [];
  //       array_push($objDB->tables, $table);
  //     }
  //   }

  //   // Get column details for the given tables
  //   $mapString = ["char","varchar","tinytext","text","mediumtext","longtext","binary",
  //                 "varbinary","date","datetime","timestamp","time","year"];
  //   $mapNumber = ["bit","tinyint","smallint","mediumint","int","integer","bigint",
  //                 "decimal","dec","fixed","float","double","real"];
  //   $mapBoolean = ["bool", "boolean"];
  //   for ($i = 0; $i < count($objDB->tables); $i++) {
  //     $name = $objDB->tables[$i]->name;
  //     $r = $this->db->query("SHOW COLUMNS FROM $name;");
  //     if ($r->num_rows > 0) {
  //       while($row = $r->fetch_assoc()) {
  //         $column = new stdClass();
  //         $column->name = $row["Field"];
  //         $type = new steveorevo\GString($row["Type"]);
  //         $type = $type->getLeftMost("(")->__toString();
  //         $column->mysql_type = $type;
  //         if (FALSE !== in_array($type, $mapString)) {
  //           $type = "string";
  //         }else{
  //           if (FALSE !== in_array($type, $mapNumber)) {
  //             $type = "number";
  //           }else{
  //             if (FALSE !== in_array($type, $mapBoolean)) {
  //               $type = "boolean";
  //             }else{
  //               $type = NULL;
  //             }
  //           }
  //         }
  //         $column->json_type = $type;
  //         array_push($objDB->tables[$i]->columns, $column);
  //       }
  //     }
  //   }

  //   // Dump data for the given tables
  //   for ($i = 0; $i < count($objDB->tables); $i++) {
  //     $name = $objDB->tables[$i]->name;
  //     $r = $this->db->query("SELECT * FROM $name;");
  //     if ($r->num_rows > 0) {
  //       $data = [];
  //       while($row = $r->fetch_assoc()) {
  //         array_push($objDB->tables[$i]->data, (object)$row);
  //       }
  //     }
  //   }
  //   $this->db->close();
  //   $output = $this->climate->arguments->get('output');
  //   if (NULL === $output) {
  //     $output = getcwd() . "/" . $database . ".json";
  //   }
  //   file_put_contents($output, json_encode($objDB, JSON_PRETTY_PRINT));
  //   exit();
  // }

  /**
   * List available databases or tables for a given database
   */
  function doListing() {
    if (! $this->climate->arguments->defined('list')) return;
    $this->parseJSONFile();
    echo "JSON file contains database " . $this->jsonDB->name . " with tables:\n";
    foreach($this->jsonDB->tables as $table) {
      echo "   $table->name\n";
    }
    exit();
  }

  /**
   * Read and parse the given JSON database file
   */
  function parseJSONFile() {
    $json_file = $this->climate->arguments->get('json_file');
    if (NULL == $json_file) {
      echo "Error, missing JSON file: $json_file\n";
      exit();
    }else{
      if (FALSE === file_exists($json_file)) {
        $json_file = getcwd() . "/$json_file";
        if (FALSE === file_exists($json_file)) {
          echo "Error, missing JSON file: $json_file\n";
          exit();
        }
      }
    }
    try {
      $this->jsonDB = json_decode(file_get_contents($json_file));
    } catch (Exception $e) {
      echo 'Error, parsing JSON file: ',  $e->getMessage(), "\n";
      exit();
    }
  }

  /**
   * Show the version number
   */
  function showVersion() {
    if (! $this->climate->arguments->defined('version')) return;
    echo "JSON2MySQL version " . $this->version . "\n";
    echo "Copyright ©2018 Stephen J. Carnam\n";
    exit();
  }

  // /**
  //  * Gather the list of tables in the given database
  //  */
  // function getTables() {
  //   $database = $this->climate->arguments->get('database');
  //   $this->connectToDB($database);
  //   $r = $this->db->query('SHOW TABLES;');
  //   if ($r->num_rows > 0) {
  //     while($row = $r->fetch_assoc()) {
        
  //       // Limit to implicit tables argument if present
  //       $name = $row["Tables_in_$database"];
  //       if ($this->climate->arguments->defined('tables')) {
  //         $t = ',' . $this->climate->arguments->get('tables') . ',';
  //         if (FALSE !== strpos($t, $name)) {
  //           array_push($this->tables, $name);
  //         }
  //       }else{
  //         array_push($this->tables, $name);
  //       }
  //     }
  //   }
  //   $this->db->close();
  // }

  /**
   * Gather a list of available databases
   */
  function getDBNames() {
    $this->connectToDB();
    $r = $this->db->query('SHOW DATABASES;');
    if ($r->num_rows > 0) {
      while($row = $r->fetch_assoc()) {
          array_push($this->dbNames, $row["Database"]);
      }
    }
    $this->db->close();
  }

  /**
   * Connect to the mysql database with the given credentials
   * string - the name of the database to connect to, default is mysql
   */
  function connectToDB($database = "mysql") {
    $host = $this->climate->arguments->get('host');
    if ($host == 'localhost') {
      $host = '127.0.0.1';
    }
    $user = $this->climate->arguments->get('user');
    $password = $this->climate->arguments->get('password');
    $this->db = new mysqli($host, $user, $password, $database);
    if (!$this->db->set_charset("utf8")) {
      printf("Error loading character set utf8: %s\n", $this->db->error);
      exit();
    }
    if ($this->db->connect_error) {
      die('Connection failed: ' . $this->db->connect_error);
    }
  }
}

// From command line, create instance & do cli arguments
if ( PHP_SAPI === 'cli' ) {
  $myCmd = new JSON2MySQL();
  $name = new Steveorevo\GString(__FILE__);
  $argv[0] = $name->getRightMost("/")->delRightMost(".");
  $myCmd->cli();
}
