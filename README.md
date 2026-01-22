# Ontology of an Electronic Circuit (Protégé)

This project presents the design and implementation of an **ontology for an electronic circuit system** using **Protégé**.  
It was developed as part of the course **Knowledge Systems (Συστήματα Γνώσης)** during the academic year 2024–2025.

The ontology models the structural components of a circuit, including electronic components, sensors, inputs, outputs, and operational cycles, in a generic and reusable manner.

---

## 📘 Project Description

The ontology represents a knowledge-based model of an electronic circuit and its components, allowing formal reasoning and integration with rule-based systems.

According to the project report (page 1), the goal was to design classes that model the components of a knowledge system, including their properties, constraints, and relationships with other classes.

---

## 🧩 Main Classes

From the ontology specification:

### 1. System
Represents the complete electronic system.

**Key properties:**
- `hasInput` → Input
- `hasOutput` → Output
- `hasSensor` → Sensor
- `hasComponent` → ElectronicComponent

### 2. ElectronicComponent (Superclass)

Subclasses:
- `Adder`
- `Multiplier`

**Key properties:**
- `hasInput`
- `hasOutput`
- `hasStatus` (Normal, Short-circuit, MSB-off)
- `MonitoredBy`
- `ComponentTo` (links to System)

### 3. Input
Represents input values to the system.

Properties include:
- `InputValue`
- `InputTo`
- `MonitoredBy`

### 4. Output
Represents the final output of the circuit.

Properties include:
- `OutputValue`
- `OutputTo`
- `MonitoredBy`

### 5. Sensor
Monitors components and system behavior.

Properties include:
- `Measures`
- `Monitors`
- `SensorTo`
- `hasStatus`

### 6. OperationCycle
Represents time cycles of system operation.

Includes:
- Input values (Input1–Input4)
- Output value
- Sensor measurements (M1–M3)

---

## 🗂 Ontology Design

The ontology is designed to be:

- **Generic**
- Independent of a specific circuit topology
- Extensible to different electronic systems

A full class hierarchy diagram is provided in the report (page 3), showing:

