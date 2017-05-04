## Incidence of Gonorrhea and Chlamydia Following HIV Preexposure Prophylaxis among Men Who Have Sex with Men: A Modeling Study

This repository holds the source to code to reproduce the analysis featured in our Gonorrhea (GC) and Chlamydia (CT) transmission model among men who have sex with men in the United States. This study investigated the relationship between the scale of HIV preexposure prophylaxis (PREP) and STI incidence in US MSM, to understand the causal questions and public health implications surrounding the potentially countervailing phenomena of increased behavioral risk with PrEP-uptake and additional screening and treatment of STIs after PrEP initiation.

<img src="https://github.com/statnet/stiPrEP/raw/master/analysis/Fig1.jpg">

## Citation

> Jenness SM, Weiss KM, Goodreau SM, Gift T, Chesson H, Hoover KW, Smith DK, Liu AY, Sullivan PS, Rosenberg ES. Incidence of Gonorrhea and Chlamydia Following HIV Preexposure Prophylaxis among Men Who Have Sex with Men: A Modeling Study. _In Press: Clinical Infectious Diseases._

## Abstract

### Background
Preexposure prophylaxis (PrEP) is highly effective for preventing HIV, but risk compensation (RC) in men who have sex with men (MSM) raises concerns about increased sexually transmitted infections (STIs). CDC’s PrEP guidelines recommend biannual STI screening, which may reduce incidence by treating STIs that would otherwise remain undiagnosed. We investigated the impact of these two potentially counteracting phenomena.

### Methods
With a stochastic network-based mathematical model of HIV and rectal/urogenital Neisseria gonorrhoeae (NG) and Chlamydia trachomatis (CT) transmission dynamics among MSM in the United States, we simulated PrEP uptake following the prescription indications and HIV/STI screening recommendations in the CDC guidelines. Model scenarios varied PrEP coverage (the proportion of MSM indicated for PrEP who received it), RC (as a reduction in the per-act probability of condom use), and the STI screening interval.

### Results
In our reference scenario (40% coverage, 40% RC), 42% of NG and 40% of CT infections would be averted over the next decade. A doubling of RC would still result in net STI prevention relative to no PrEP. STIs declined because PrEP-related STI screening resulted in a 17% and 16% absolute increase in the treatment of asymptomatic and rectal STIs, respectively. Screening and timely treatment at quarterly vs biannual intervals would reduce STI incidence a further 50%.

### Conclusions
Implementation of the CDC PrEP guidelines while scaling up PrEP coverage could result in a significant decline in STI incidence among MSM. Our study highlights the design of PrEP not only as antiretroviral medication, but as combination HIV/STI prevention incorporating STI screening.

<img src="https://github.com/statnet/stiPrEP/raw/master/analysis/Fig2.jpg">

## Model Code

These models are written and executed in the R statistical software language. To run these files, it is necessary to first install our epidemic modeling software, [EpiModel](http://epimodel.org/), and our extension package specifically for modeling HIV and STI transmission dynamics among MSM, [EpiModelHIV](http://github.com/statnet/EpiModelHIV).

In R:
```
install.packages("EpiModel")

# install devtools if necessary, install.packages("devtools")
devtools::install_github("statnet/tergmLite")
devtools::install_github("statnet/EpiModelHIV", ref = "prep-sti")
```




