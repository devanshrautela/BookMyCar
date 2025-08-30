package in.sp.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConfig {
    
    // Database configuration
    private static final String DB_NAME = "BookMyCarDB";
    private static final String DB_PATH = "./" + DB_NAME; // Relative path in current directory
    private static final String JDBC_URL = "jdbc:derby:" + DB_PATH + ";create=true";
    private static final String DRIVER_CLASS = "org.apache.derby.jdbc.EmbeddedDriver";
    
    // Singleton connection instance
    private static Connection connection = null;
    
    static {
        try {
            // Load Derby driver
            Class.forName(DRIVER_CLASS);
            System.out.println("Derby driver loaded successfully");
        } catch (ClassNotFoundException e) {
            System.err.println("Error loading Derby driver: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    /**
     * Get database connection
     * @return Connection object
     * @throws SQLException if connection fails
     */
    public static Connection getConnection() throws SQLException {
        if (connection == null || connection.isClosed()) {
            try {
                connection = DriverManager.getConnection(JDBC_URL);
                System.out.println("Database connected successfully to: " + DB_PATH);
                
                // Create tables if they don't exist
                createTablesIfNotExist(connection);
                
            } catch (SQLException e) {
                System.err.println("Error connecting to database: " + e.getMessage());
                throw e;
            }
        }
        return connection;
    }
    
    /**
     * Create database tables if they don't exist
     */
    private static void createTablesIfNotExist(Connection con) {
        try {
            // Create Customer table
            String createCustomerTable = 
                "CREATE TABLE Customer (" +
                "id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1), " +
                "Firstname VARCHAR(50), " +
                "Lastname VARCHAR(50), " +
                "ContactDetails VARCHAR(100), " +
                "Residence VARCHAR(100), " +
                "UserName VARCHAR(50) UNIQUE, " +
                "Password VARCHAR(255), " +
                "Salted VARCHAR(255), " +
                "PRIMARY KEY (id))";
            
            // Create Car table
            String createCarTable = 
                "CREATE TABLE Car (" +
                "id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1), " +
                "name VARCHAR(100), " +
                "number VARCHAR(20) UNIQUE, " +
                "rating DECIMAL(3,1), " +
                "seater INTEGER, " +
                "price DECIMAL(10,2), " +
                "carType VARCHAR(50), " +
                "Transmission VARCHAR(20), " +
                "fuelType VARCHAR(20), " +
                "modelYear INTEGER, " +
                "booked VARCHAR(3) DEFAULT 'No', " +
                "PRIMARY KEY (id))";
            
            // Create Bookings table
            String createBookingsTable = 
                "CREATE TABLE Bookings (" +
                "id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1), " +
                "name VARCHAR(100), " +
                "number VARCHAR(20), " +
                "fullname VARCHAR(100), " +
                "phone VARCHAR(20), " +
                "pickup_date DATE, " +
                "return_date DATE, " +
                "card_number VARCHAR(20), " +
                "expiry_date VARCHAR(10), " +
                "cvv VARCHAR(5), " +
                "PRIMARY KEY (id))";
            
            // Execute table creation (ignore if tables already exist)
            try {
                con.createStatement().execute(createCustomerTable);
                System.out.println("Customer table created successfully");
            } catch (SQLException e) {
                // Table might already exist, ignore error
                System.out.println("Customer table already exists or error: " + e.getMessage());
            }
            
            try {
                con.createStatement().execute(createCarTable);
                System.out.println("Car table created successfully");
            } catch (SQLException e) {
                System.out.println("Car table already exists or error: " + e.getMessage());
            }
            
            try {
                con.createStatement().execute(createBookingsTable);
                System.out.println("Bookings table created successfully");
            } catch (SQLException e) {
                System.out.println("Bookings table already exists or error: " + e.getMessage());
            }
            
        } catch (Exception e) {
            System.err.println("Error creating tables: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    /**
     * Close database connection
     */
    public static void closeConnection() {
        if (connection != null) {
            try {
                connection.close();
                System.out.println("Database connection closed");
            } catch (SQLException e) {
                System.err.println("Error closing connection: " + e.getMessage());
            }
        }
    }
    
    /**
     * Get database path for debugging
     */
    public static String getDatabasePath() {
        return DB_PATH;
    }
}
