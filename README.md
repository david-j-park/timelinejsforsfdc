# Timelines for Salesforce.com

This project is a port of the amazing [TimelineJS library](http://timeline.knightlab.com/) to the Salesforce.com platform. It includes the following:

* Custom object definitions for Timelines, Slides, and Eras
* A visualforce page for displaying your timelines
* Lightning components for editing your timeline (very rough) and (one day) slides
* Sample data

## Usage

You'll need to install Salesforce DX tooling to use this code. If you're new to DX, [start here](https://developer.salesforce.com/platform/dx).

Clone the repository, push the source to a scratch org, and import the sample data:

```
sfdx force:data:tree:import -p data/Timeline__c-Timeline_Slide__c-plan.json
```