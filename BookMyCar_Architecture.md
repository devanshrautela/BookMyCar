%% Simplified BookMyCar System Architecture
flowchart TB
    %% Client Layer
    subgraph Client["Client Layer"]
        User[End User]
        Admin[Admin User]
        Browser[Web Browser]
        User --> Browser
        Admin --> Browser
    end

    %% Presentation Layer
    subgraph Presentation["Presentation Layer (JSP Pages)"]
        JSP[JSP Pages<br/>Login, Register, Browse, Booking, Payment, Admin Dashboard, Errors]
    end

    %% Controller Layer
    subgraph Controller["Controller Layer (Servlets)"]
        Servlets[Servlets<br/>Authentication, Car Mgmt, Booking Mgmt, User Mgmt, Admin Ops]
    end

    %% Business Logic Layer
    subgraph Business["Business Logic Layer (DAO)"]
        DAO[DAO Classes<br/>CarDAO, CustomerDAO, BookingDAO, DatabaseConfig]
    end

    %% Data Model Layer
    subgraph DataModel["Data Model Layer (Beans)"]
        Beans[Entity Beans<br/>Car, Customer, Booking, SecurityAuth]
    end

    %% Database Layer
    subgraph Database["Database Layer (Apache Derby)"]
        Tables[(Tables<br/>Car, Customer, Booking)]
    end

    %% Server Layer
    subgraph Server["Server Layer"]
        Tomcat[Apache Tomcat<br/>Port 8080]
        WebXML[web.xml Config]
    end

    %% Connections
    Browser --> JSP
    JSP --> Servlets
    Servlets --> DAO
    DAO --> Database
    DAO --> Beans
    Tomcat --> JSP
    Tomcat --> Servlets
    Tomcat --> WebXML

    %% Styling
    classDef client fill:#e1f5fe
    classDef presentation fill:#f3e5f5
    classDef controller fill:#e8f5e8
    classDef business fill:#fff3e0
    classDef data fill:#fce4ec
    classDef database fill:#f1f8e9
    classDef server fill:#e0f2f1

    class User,Admin,Browser client
    class JSP presentation
    class Servlets controller
    class DAO business
    class Beans data
    class Tables database
    class Tomcat,WebXML server
