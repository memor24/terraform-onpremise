
resource github_repository "new_repo"{
    name= "example"
    visibility="public"
}

resource github_repository_file "new_file"{
    repository=github_repository.new_repo.name
    branch="main"
    file="sth"
    content="some content"
    commit_message="updated a new file"
    commit_author="current user"
    overwrite_on_create=true
    autocreate_branch=true
} 

resource "github_branch" "new_branch" {
  repository = "test"
  branch     = "dev"
}

resource github_repository_pullrequest "new_pullrequest"{
    base_repository=github_repository.new_repo.name
    base_ref="main"
    head_ref="dev/feature"
    title="new feature PR"
    body="details about the feature"
}