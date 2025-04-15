# Spice.ai Tableau Connector

The Spice.ai Tableau Connector is a JDBC-based connector that enables Tableau users to easily connect to and visualize data from self-hosted Spice.ai Open Source and Spice Cloud Platform instances.

## Features

- Connect Tableau to Spice data sources: [Spice Cloud Platform](https://spice.ai/), self-hosted [Spice.ai OSS](https://spiceai.org/)
- API key authentication
- TLS encryption for secure connections
- Advanced SQL query [optimizations](https://tableau.github.io/connector-plugin-sdk/docs/capabilities) for enhanced performance, leveraging the [Apache Arrow Flight SQL JDBC Driver](https://arrow.apache.org/docs/java/flight_sql_jdbc_driver.html) to provide high-speed data access compared to standard JDBC connector.

## Installation

### Step 1. Install Arrow Flight SQL JDBC Driver

#### Windows

```powershell
Invoke-WebRequest -Uri "https://repo1.maven.org/maven2/org/apache/arrow/flight-sql-jdbc-driver/16.1.0/flight-sql-jdbc-driver-16.1.0.jar" -OutFile "C:\Program Files\Tableau\Drivers\flight-sql-jdbc-driver-16.1.0.jar"
```

#### macOS

```bash
curl -L https://repo1.maven.org/maven2/org/apache/arrow/flight-sql-jdbc-driver/16.1.0/flight-sql-jdbc-driver-16.1.0.jar -o ~/Library/Tableau/Drivers/flight-sql-jdbc-driver-16.1.0.jar
```

#### Linux

```bash
curl -L https://repo1.maven.org/maven2/org/apache/arrow/flight-sql-jdbc-driver/16.1.0/flight-sql-jdbc-driver-16.1.0.jar -o /opt/tableau/tableau_driver/jdbc/flight-sql-jdbc-driver-16.1.0.jar
```

### Step 2. Install Spice.ai Tableau Connector

#### Tableau Server

1. Download the latest `spiceai.taco` file from the [releases page](https://github.com/spicehq/tableau-connector/releases)
2. Copy to your Tableau connectors directory:
   - Windows: `C:\Program Files\Tableau\Connectors`

      ```powershell
      Invoke-WebRequest -Uri "https://github.com/spicehq/tableau-connector/releases/latest/download/spiceai.taco" -OutFile "C:\Program Files\Tableau\Connectors\spiceai.taco"
      ```

   - Linux: `/opt/tableau/connectors`

      ```bash
      curl -L https://github.com/spicehq/tableau-connector/releases/latest/download/spiceai.taco -o /opt/tableau/connectors/spiceai.taco
      ```

3. Restart server: `tsm restart`

#### Tableau Desktop

1. Download the latest `spice.taco` file from the [releases page](https://github.com/spiceai/tableau-connector/releases)
2. Copy to your Tableau connectors directory:
   - Windows: `C:\Users\[USERNAME]\Documents\My Tableau Repository\Connectors`

      ```powershell
      Invoke-WebRequest -Uri "https://github.com/spicehq/tableau-connector/releases/latest/download/spiceai.taco" -OutFile "C:\Users\[USERNAME]\Documents\My Tableau Repository\Connectors\spiceai.taco"
      ```

   - macOS: `~/Documents/My Tableau Repository/Connectors`

      ```bash
      curl -L https://github.com/spicehq/tableau-connector/releases/latest/download/spiceai.taco -o ~/Documents/My\ Tableau\ Repository/Connectors/spiceai.taco
      ```

   - Linux: `/opt/tableau/connectors`

      ```bash
      curl -L https://github.com/spicehq/tableau-connector/releases/latest/download/spiceai.taco -o /opt/tableau/connectors/spiceai.taco
      ```

## Limitations

### Multiplication and Division on Intervals Are Not Supported

Multiplying or dividing intervals is not supported and will result in a `Cannot coerce arithmetic expression` error. For example:

```sql
SELECT "orders"."order_date" + "orders"."delivery_days" * INTERVAL '1 DAY'
```

```text
Error during planning: Cannot coerce arithmetic expression Int64 * Interval(MonthDayNano) to valid types
```

The limitation is due to limited arithmetic operations support for Interval by DataFusion, tracked as [apache/datafusion#13850](https://github.com/apache/arrow-datafusion/issues/13850).

## Development

### Prerequisites

- `make` command-line tool
- Python 3.x installed
- Clone the repository

```bash
git clone https://github.com/spiceai/tableau-connector.git
cd tableau-connector
```

### Run Connector

```bash
# Run Tableau with the connector loaded from source
make run-tableau-with-connector

# Clean build artifacts
make clean
```

### Run Tests

The connector uses [TDVT framework](https://tableau.github.io/connector-plugin-sdk/docs/tdvt).

```bash
# Package and install
make install

# Run Spice instance
cd tdvt && spice run

# Run TDVT tests with the installed Spice connector
make test
```

### Package

```bash
# Create an unsigned `spice.taco` connector version
make package
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
