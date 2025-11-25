## Reducing the Number of High-Fatality Road Accidents

Analysis of UK Road Safety Data

### Overview

This project explores a real-world road safety dataset to identify the factors contributing to high-fatality traffic accidents. The goal is to support data-driven recommendations that help transportation authorities, safety units, and policy makers reduce the frequency and severity of major incidents.

The project was completed as part of a DataCamp competition and follows a structured approach: data understanding, cleaning, exploration, feature interpretation, and insight generation.

---

## Dataset

The analysis uses the UK Government’s official road safety open dataset. It contains information on:

* Accident characteristics
* Casualty data
* Vehicle attributes
* Road types and conditions
* Weather and environmental factors

Relevant lookup codes were merged to convert categorical codes into human-readable labels.

---

## Objectives

1. Identify the conditions that significantly increase the likelihood of fatal accidents.
2. Understand patterns across road types, environments, times, weather, and vehicle categories.
3. Provide actionable recommendations that can help reduce fatalities and prioritize safety interventions.

---

## Key Steps in the Analysis

### 1. Data Loading and Cleaning

* Merged accident datasets with lookup tables for clarity.
* Handled missing values and standardized categorical fields.
* Selected relevant variables affecting accident severity.

### 2. Exploratory Data Analysis

* Identified distributions of accident severity across regions, times, and road types.
* Compared fatal versus non-fatal accidents to uncover differentiating factors.
* Examined interactions between weather, vehicle type, speed limits, and accident outcomes.

### 3. Insight Generation

Some of the insights explored include (general examples, adaptable to your notebook):

* Fatal accidents occur more frequently on higher-speed roads.
* Night-time and poor-visibility conditions show a disproportionate number of severe incidents.
* Motorcycles and heavy vehicles contribute significantly to high-impact crashes.
* Rural roads show more fatal accidents than urban environments despite fewer total incidents.

### 4. Recommendations

The analysis suggests targeted strategies such as:

* Focusing safety interventions on rural, high-speed roads.
* Improving visibility infrastructure in low-light conditions.
* Enforcing stricter awareness and safety measures for high-risk vehicle categories.
* Enhancing weather-related warning systems.

---

## Tools and Technologies

* Python
* Pandas
* NumPy
* Matplotlib
* Jupyter Notebook


Link to published competition on datacamp: https://www.datacamp.com/datalab/w/ef4f569b-1a05-4fc5-b97b-2ec0fa2b6b56
