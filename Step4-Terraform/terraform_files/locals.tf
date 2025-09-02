locals {
    common_tags = {
        Name = "my-SonarQube"
        Environment = var.region
        Team = "Group-2"
        Project = "SonarQube"
    }
}