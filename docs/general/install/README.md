# Installation Techniques

## Terraform Module Sources

All the techniques for installing modules are based around the ways that Terraform modules are sourced. Terraform provides good documentation on this [here][tf-module-sources].

## Preferred Method

### Using the Repo Source

Assuming you don't have manual modifications that you need to make to serve the purposes of an application, the most convenient method of integrating modules might be by using the repo source of this module like so:

```hcl
module "MOD_SHORTNAME" {
    source = "github.com/pbs/terraform-MOD_NAME?ref=x.y.z"
}
```

The advantage of installing the module like this is that the module code does not reside in the application repository, and that no manual changes can be performed within the application repository, ensuring that resources are provisioned according to the remote module specifications.

The disadvantage is that this can slow down the provisioning process, especially when large or a large number of modules are being used. In addition, the requirement to have a bespoke manual adjustment to the module can require that the integration method be changed, causing inconsistencies in the application.

Note that the provider being used might also have availability or security implications to account for. If this module is being used without being forked, then the ability to use your module will be dependent on the availability of GitHub. If you do decide to fork this repository, then the repository hosting solution of your choice might have reduced availability or require require SSH key management if the source code is not hosted publicly.

## Alternative Installation Methods

### Manual Installation

You can install the minified module directly in your repo manually like so:

```bash
mkdir -p 'terraform/modules/MOD_SHORTNAME'
gh -R 'pbs/terraform-MOD_NAME' release download -p 'release.tar.gz' x.y.z
tar -xvf release.tar.gz -C 'terraform/modules/MOD_SHORTNAME'
rm -f release.tar.gz
```

The files will be introduced into your repository as normal, uncommitted files, and must be managed through git manually.

### Git Subtrees

You can use this module (or private forks of this module) without authentication during initialization by incorporating this Terraform module as a Git Subtree and referencing the repo by path to source, in a similar fashion to the examples in this repo.

Please [read this][atlassian-subtree] for information about Git Subtrees, as that will give you a better idea of how they work than the explanation here.

The simplest use case would work like so:

```bash
git remote add -f MOD_SHORTNAME git@github.com:pbs/terraform-MOD_NAME.git
git subtree add --prefix terraform/modules/MOD_SHORTNAME MOD_SHORTNAME main --squash
```

If necessary, pin the repo version, rather than adding `main` as your subtree:

```bash
git subtree add --prefix terraform/modules/MOD_SHORTNAME MOD_SHORTNAME $REF --squash
```

Where `$REF` is a commit SHA, tag, or branch name.

Note that unlike submodules, any changes that you make here will be committed back to your repo, rather than the module. This can allow you to make manual modifications that suite your application without updating the source module.

If your changes are testable and widely applicable, please consider sharing your contributions in a pull request to the module!

[atlassian-subtree]: https://www.atlassian.com/git/tutorials/git-subtree
[tf-module-sources]: https://www.terraform.io/language/modules/sources
