# CIAgentCount

<ul>
  <li>This Project is designed to identify all the CI pipeline using Microsoft based Agent Pool </li>
  <li>This project uses <b>rest api</b> to fetch all the <b>Project Name</b> in your organisation and through its response we fetch each project's agent pool</li>
  <br>
  <li>This Project will generate 3 CSV files :</li>
  <ol type="1">
    <li><b>CI-Agents-<env>.csv</b> : This file contains name of all the projects with the name of Agent-Pool used</li>
      <li><b>CIMicrosoftAgentCount<env>.csv</b> : This file contains the count of pipelines using Microsoft-Agent pool in each project </li>
        <li><b>CIMicrosoftAgentTrack<env>.csv</b> : This file will contain all the pipeline in the each <b>Project</b> using <b>Mcrosoft Agent agent</b></li>
  </ol>
      <li>Working of this Script</li>
        - In my case I has two url link https://dev.azure.com/Utsav-HE && https://dev.azure.com/Utsav-DEV.
        <br>
        - So I had variablelised the HE and DEV environments depending on which env I want output I will enter that.
        <br>
        - Then Enter the pat-token, the Code will generate its output file
</ul>
