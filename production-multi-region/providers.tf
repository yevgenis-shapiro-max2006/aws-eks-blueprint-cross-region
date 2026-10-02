provider "aws" {
  alias = "eu_west_1"
  region = "eu-west-1"
  default_tags { tags = local.tags }
}
provider "aws" {
  alias = "eu_west_2"
  region = "eu-west-2"
  default_tags { tags = local.tags }
}