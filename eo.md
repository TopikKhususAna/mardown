@startuml
!theme plain
skinparam Linetype ortho
skinparam shadowing false
skinparam class {
BackgroundColor White
ArrowColor #2688d4
BorderColor #2688d4
}

' --- ENTITIES ---

entity "clients" as clients {

- id : INT <<PK>>
  --
  client_name : VARCHAR
  email : VARCHAR
  phone : VARCHAR
  address : TEXT
  company : VARCHAR
  }

entity "employees" as employees {

- id : INT <<PK>>
  --
  first_name : VARCHAR
  last_name : VARCHAR
  email : VARCHAR
  phone : VARCHAR
  position : VARCHAR
  salary : DECIMAL
  }

entity "event_types" as event_types {

- id : INT <<PK>>
  --
  type_name : VARCHAR
  description : TEXT
  }

entity "venues" as venues {

- id : INT <<PK>>
  --
  venue_name : VARCHAR
  address : TEXT
  city : VARCHAR
  capacity : INT
  price_per_day : DECIMAL
  }

entity "events" as events {

- id : INT <<PK>>
  --
  event_name : VARCHAR
  event_type_id : INT <<FK>>
  client_id : INT <<FK>>
  venue_id : INT <<FK>>
  event_date : DATE
  start_time : TIME
  end_time : TIME
  budget : DECIMAL
  status : VARCHAR
  }

entity "employees_events" as event_staff {

- event_id : INT <<FK>>
- employee_id : INT <<FK>>
  --
  role : VARCHAR
  }

entity "vendors" as vendors {

- id : INT <<PK>>
  --
  vendor_name : VARCHAR
  service_type : VARCHAR
  phone : VARCHAR
  email : VARCHAR
  address : TEXT
  price : DECIMAL
  }

entity "event_vendors" as event_vendors {

- event_id : INT <<FK>>
- vendor_id : INT <<FK>>
  --
  service_cost : DECIMAL
  }

entity "payments" as payments {

- id : INT <<PK>>
  --
  event_id : INT <<FK>>
  payment_date : DATE
  amount : DECIMAL
  payment_method : VARCHAR
  payment_status : VARCHAR
  }

entity "tickets" as tickets {

- id : INT <<PK>>
  --
  event_id : INT <<FK>>
  ticket_type : VARCHAR
  price : DECIMAL
  quantity : INT
  }

entity "attendees" as attendees {

- id : INT <<PK>>
  --
  event_id : INT <<FK>>
  name : VARCHAR
  email : VARCHAR
  phone : VARCHAR
  }

' --- RELATIONSHIPS ---

events }|--|| clients
events }|--|| venues
events }|--|| event_types

event_staff }|--|| events
event_staff }|--|| employees

event_vendors }|--|| events
event_vendors }|--|| vendors

payments }|--|| events

tickets }|--|| events

attendees }|--|| events

@enduml