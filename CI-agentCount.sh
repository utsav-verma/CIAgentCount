# inputs
read -p "Environment Name : " env
read -p "Pat Token : " pat

# CI-URL
org_url="https://dev.azure.com/<org>+$env"
url="https://dev.azure.com/<org>$env/_apis/projects?api-version=6.0"

#response
response=$(curl -s -u ":$pat" "$url")

# Fetching Project Name in Organisation
project_names=$(echo "$response" | jq -r '.value[].name')

# Removing whitespace and switching it with %20
modified_string=$(echo "$project_names" | sed 's/ /%20/g; s/'"'"'//g')

while IFS= read -r project; do
# Azure DevOps REST API URL for pipelines in a project
pipelines_url="$org_url/$project/_apis/build/definitions?api-version=6.0"

# Removing %20 and replacing it with space
newProject=$(echo "$project" | sed 's/%20/ /g')

#response
build_definitions=$(curl -s -u ":$pat" "$pipelines_url")
echo -e "\n"
echo "---------------------------------"
echo $newProject
# Make the API request using curl

# Parse JSON response to extract pipeline names using Microsoft-hosted agents
echo "Pipelines using Microsoft-hosted agents:"
echo "----------------------------------------"
count=0

# Storing Microsoft Based Agents
CI_name=$(echo "$build_definitions" | jq -r '.value[] | select(.queue.pool.name == "Azure Pipelines" and .queue.pool.isHosted == true) | .name')
echo "$build_definitions" | jq --arg project "$newProject" -r '.value[] | "\($project), \(.name), \(.queue.pool.name)"' >> "CI-Agents-$env.csv"
#----------------------------------------------


count=0
if [ -n "$CI_name" ]; then
    while IFS= read -r name; do
        echo "$name"
        echo $newProject,$name >> "CIMicrosoftAgentTrack$env.csv"
        ((count++))
    done <<< "$CI_name"
    echo $newProject,$count >> "CIMicrosoftAgentCount$env.csv"
    echo "$count"
else
    echo "No CI implemented"
    echo $newProject,$count >> "CIMicrosoftAgentCount$env.csv"
fi

echo -e "\n"

done <<< "$modified_string"