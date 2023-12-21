# guestbook-go

## Assignment I (Continuous Integration Pipeline)
### Problem Statment:
#### Phase 1:
- Create a new GitHub public repo from [repo](https://github.com/kubernetes/examples/tree/master/guestbook-go)
- Create a container image using the Github Action workflow for the above project.
- Push that image to the docker hub.(https://hub.docker.com/r/artimule23/guestbook-go-container/tags)
  
#### Phase 2:
- Deploy container image built in above step(Phase I) on local/any kubernetes cluster.

#### Phase 3:
- Prevent merging anything in main branch without review.
- Build container image only when one of the below conditions is true:
    - When PR get merged in main/master branch from any other branch.
    - When commit message contains `BUILD_CONTAINER_IMAGE` string
