# Survival-Analysis
#### UW BIOST 537/EPI 537: Survival Data Analysis In Epidemiology (Winter 2023)
instructor: Jon Wakefield

#### Final Project

## Background

Leukemia is a cancer of the blood that consists of numerous subtypes based on the type of blood cells infected and the rate of differentiation.A slower-growing leukemia is classified as acute. A standard treatment for acute leukemia is a bone marrow transplant (BMT). BMTs can be allogeneic, meaning a patient receives cells from a donor, or autologous, where the patient is its own donor.  The ultimate goal of a BMT is for successful engraftment of healthy stem cells into a host and an increase in platelet counts. Studies show that the success of a BMT can depend on various factors known at the time of transplantation, such as the age and sex of the patient and/or donor, the stage of the initial disease, and the time elapsed since disease diagnosis. As the patient undergoes post-transplantation experiences, the ultimate prognosis may change due to unpredictable events, such as the occurrence of acute graft-versus-host disease (aGVHD) or the recovery of platelet counts.A transplant is considered unsuccessful if a patient relapses or passes away during remission. 

The analyzed study data were collected to gather information on certain characteristics of patients and donors, as well as events during the transplant process, to determine whether risks of relapse or death are predictable. The study was conducted at four hospitals in the United States and Australia, and included 137 patients who received a radiation-free conditioning regimen of oral Busulfan and intravenous cyclophosphamide. The researchers assessed and noted various factors such as patient and donor age and sex, cytomegalovirus (CMV) immune status, wait time from diagnosis to transplant, disease group, FAB classification, and prophylactic use of methotrexate. Disease group refers to a classification of acute lymphoblastic leukemia (ALL), and high- and low-risk acute myelocytic leukemia (AML). FAB classification grades leukemia subtypes based on affected cells. For the purposes of this analysis, a grade of 4, 5, or AML will be categorized as one group and the other subtypes will be grouped together separately. These variables will henceforth be referred to as baseline characteristics or factors. Patients were followed until the end of the study or death.

Previous studies have suggested that the patient’s CMV status may be associated with morbidity and mortality. Patients who are positive for CMV may have a higher risk of complications such as GVHD, increased rates of infections, and organ damage. However, the use of immunosuppressive therapy, like methotrexate, to prevent GVHD can further increase the risk of CMV reactivation, leading to a higher risk of mortality. Therefore, understanding how a patient’s CMV status affects BMT outcome is crucial for predicting the risk of death or relapse. 

## Objective

The objective of this study is to investigate disease-free survival in patients who have undergone a BMT for leukemia. In particular, the study seeks to estimate the disease-free survival time for enrolled patients, compare patients in different disease groups or FAB classifications with respect to available baseline measurements, and determine if any of the measured baseline variables are associated with differences in disease-free survival. Furthermore, the study aims to explore the relationship between the occurrence of aGVHD after transplantation and disease-free survival, as well as investigate whether aGVHD is an important prognostic event. Moreover, the study will examine whether prophylactic use of methotrexate, an immunosuppressant, is associated with an increased or decreased risk of developing aGVHD, and assess the impact of the recovery to normal platelet levels on disease-free survival and relapse risk. The findings of this study will provide valuable insights into the factors affecting disease-free survival in patients with acute leukemia who have undergone a BMT, which can inform clinical decision-making and ultimately improve patient outcomes.

## Dataset

The dataset includes information on 137 patients who underwent allogeneic BMTs as treatment for acute leukemia. The variables in the dataset include patient identification, time variables (in days) until death or the end of study, wait time until transplant, onset of aGVHD, and recovery to normal platelet levels, as well as indicator variables of death, relapse, disease-free survival, development of aGVHD, recovery to normal platelet level, and prophylactic use of methotrexate. The dataset also includes disease subtype by morphologic FAB classification, disease classification (including ALL, and high- or low-risk AML), patient age, sex, and CMV status, donor age, sex, and CMV status, and recruitment center. The dataset provides information that can be used to explore factors associated with patient prognosis following BMT. 

## Questions

1. Provide an estimate of disease-free survival time for patients enrolled in this study. What are the main characteristics of this summary?

2. How do patients in different disease groups or in different FAB classifications compare to each other with respect to other available baseline measurements?

3. Are any of the measured baseline variables associated with differences in disease-free survival?

4. It is generally thought that aGVHD has an anti-leukemic effect. Based on the available data, is occurrence of aGVHD after transplantation associated with improved disease-free survival? Is it associated with a decreased risk of relapse? In view of this, do you consider aGVHD as an important prognostic event?

5. Among the patients who develop aGVHD, are any of the measured baseline factors associated with differences in disease-free survival?

6. Is prophylactic use of methotrexate associated with an increased or decreased risk of developing aGVHD? Provide an estimate of the survival function of time from transplant until onset of aGVHD separately for patients either administered methotrexate or not. In doing so, consider the importance of accounting for relevant confounding factors.

7. Based on the available data, is recovery of normal platelet levels associated with improved disease- free survival? Is it associated with a decreased risk of relapse?

