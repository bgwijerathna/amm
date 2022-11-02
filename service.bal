import ballerinax/github;
import ballerina/http;

# A service representing a network-accessible API
# bound to port `9090`.
service / on new http:Listener(9090) {

    # A resource for generating greetings
    # + name - the input string name
    # + return - string name with hello message or error
    resource function get listTopRepos() returns string|error {
        // Send a response back to the caller.

        github:Client githubEp = check new (config = {
            auth: {
                token: "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"
            }
        });
        stream<github:Repository, github:Error?> response = check githubEp->getRepositories();
        (string[]|error)? reposnames = check from var i in response
select i.name;
        string repositoryName = "";
        if (reposnames is string[]) {
            repositoryName = reposnames[0];
        }
        return repositoryName;

    }
}