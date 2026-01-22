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


# Fault Diagnosis Expert System for an Electronic Circuit (CLIPS)

This project implements a **rule-based expert system in CLIPS** for diagnosing faults in an electronic circuit.

It extends the ontology developed in Protégé by integrating the static knowledge into CLIPS templates and implementing dynamic reasoning rules for fault detection.

Course: **Knowledge Systems (Συστήματα Γνώσης)** – Academic Year 2024–2025.

---

## 📘 Project Description

The system:

- Monitors circuit inputs, outputs, and sensor values over time
- Detects abnormal behavior
- Identifies:
  - Faulty component (Adder / Multiplier)
  - Type of fault:
    - Short circuit
    - Most Significant Bit off (MSB off)
    - Sensor fault

This project follows Assignment 2 of the course and builds upon the ontology developed in Assignment 1 :contentReference[oaicite:2]{index=2}.

---

## 🧠 Knowledge Representation

### Templates

Defined for:

- Adder
- Multiplier
- OperationCycle

Each template includes:

- Inputs
- Outputs
- Sensor values
- Component status

---

### Classes (mapped from ontology)

- System
- ElectronicComponent
- Adder
- Multiplier
- Input
- Output
- Sensor
- OperationCycle

---

## 🔁 Initial Facts

Initial facts define:

- Input values (`hasInput1`–`hasInput4`)
- Sensor readings (`hasSensorM1`, `hasSensorM2`, `hasSensorM3`)
- Output value (`hasOutput`)

for each operation cycle.

---

## ⚙️ Component Behavior (Handlers)

Each component can operate in:

- **Normal operation**
- **Short circuit**
- **MSB off**

---

## 🧪 Fault Detection Rules

### Adders

Rules:

- `monitor-adder1`
- `monitor-adder2`

Logic:

| Condition | Expected Output |
|----------|-----------------|
| Normal | (input1 + input2) mod 32 |
| Short circuit | 0 |
| MSB off | (input1 + input2) mod 16 |
| Otherwise | Sensor fault |

---

### Multipliers

Rules:

- `monitor-multiplier1`
- `monitor-multiplier2`

Logic:

| Condition | Expected Output |
|----------|-----------------|
| Normal | (input1 × input2) mod 32 |
| Short circuit | 0 |
| MSB off | (input1 × input2) mod 16 |
| Otherwise | Sensor fault |

---

## ✅ Normal Operation Rule

The rule `normal-operation` confirms:

- All components
- All sensors
- All outputs

are functioning correctly, and prints a message indicating normal system operation.

---

## 🛠 Tools Used

- CLIPS expert system shell
- Protégé (ontology design)
- Text editor / IDE
