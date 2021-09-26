# rd_test_flutter_heroes

A new Flutter project.

## Observations

* Main endpoint `/all.json` contains all heroes details (powerstats, biography, etc.), however I added all APIs for specific features like powerstats, biography, etc. So it is a complete set of the provided task using all the API features using a wrapped service with Futures and parsable objects from Json to Dart object with good optimisations.

### Filters

- Gender

- Race

- Publishers

### Details

- Using wrapped services

- Each object is a card of description

- Small animations

- Added custom level system

- Non Marvel or DC publishers are green Publishers with no publisher image


### Easter Eggs

- If you make a filter and the result contains only specific publishers, background animated particles will match filtered publishers only


### Screenshots

<p float="left">
    <img src="flutter_01.png" width="195px" height="422px">
    <img src="flutter_02.png" width="195px" height="422px">
    <img src="flutter_03.png" width="195px" height="422px">
    <img src="flutter_04.png" width="195px" height="422px">
</p>

<p float="left">
    <img src="flutter_05.png" width="195px" height="422px">
    <img src="flutter_06.png" width="195px" height="422px">
    <img src="flutter_07.png" width="195px" height="422px">
    <img src="flutter_08.png" width="195px" height="422px">
</p>


### Unit tests (see: test/counter_test.dart)

<img src="flutter_test.png">