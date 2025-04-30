# Tkseal

A CLI for maintaining sealed secrets in tanka configuration repositories.

The tool knows which kuberentes context and namespace to use by reading the configuration in a tanka [environment](https://tanka.dev/tutorial/environments) directory. It can generate a `plain_secrets.json` file by looking at the existing Opaque secrets for the appropriate kuberentes context and namespace. It can then read the `plain_secrets.json` file in the environment directory, and generate a `sealed_secrets.json`. This `sealed_secrets.json` can be included in the `main.jsonnet` file like so:
```
{ secrets: import 'sealed_secrets.json' }
```

## Dependencies
* `ruby` > 2.7
* `kubectl` (
* Grafana Tanka (`tk`) ([install instructions](https://tanka.dev/install/))
* `kubeseal` ([install instructions](https://github.com/bitnami-labs/sealed-secrets?tab=readme-ov-file#kubeseal))

## Installation

```bash
git clone https://github.com/mlibrary/tkseal/
cd tkseal
gem build tkseal.gemspec
gem install ./tkseal-1.2.4.gem # or whatever the current version is
```

## Usage
```
tkseal diff PATH   
```
Shows the difference between "plain_secrets.json" and the Opaque kuberentes secrets associated with the tk environment PATH <br><br>

```
  tkseal pull PATH       
```
Saves a copy of the unencrypted Opaque secrets in the kubernetes cluster associated with the given tanka environment PATH to the file "plain_secrets.json", which is also located in the given tanka environment PATH.<br><br>

```
tkseal seal PATH       
```
Takes the secrets in "plain_secerets.json" in the given tanka environment PATH, seal them with `kubeseal` and save the resulting sealed secrets to "sealed_secrets.json" in the given tanka environment path.<br><br>

```
tkseal ready           
```
Checks that the cli dependencies are available in your shell<br><br>

```
tkseal version         
```
Returns the installed version of the application


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mlibrary/tkseal.

## License

The gem is available as open source under the terms of the [BSD3 License](https://opensource.org/licenses/BSD-3-Clause).
