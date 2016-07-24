[![Build Status](https://gitlab.com/pages/middleman/badges/master/pipeline.svg)](https://gitlab.com/octopusinvitro/octopusinvitro.gitlab.io/-/commits/master)

This [Middleman] website uses GitLab Pages.


## GitLab CI

This project's static Pages are built by [GitLab CI][ci], following the steps
defined in [`.gitlab-ci.yml`](.gitlab-ci.yml).

## Building locally

To work locally with this project, follow the steps below:

1. `bundle install`
1. Generate the website: `bundle exec middleman build`
1. Preview: `bundle exec middleman`

Read more at Middleman's [documentation][].

## Testing

```sh
bundle exec rspec
```

## To do

* [ ] 

[ci]: https://about.gitlab.com/gitlab-ci/
[documentation]: https://middlemanapp.com/basics/install/
[Middleman]: https://middlemanapp.com/
