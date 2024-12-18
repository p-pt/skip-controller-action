# Skip Controller Action

// TODO
notes: This POC (Proof of concept) project is built on top of [DevCycle Ruby Server SDK Example App](https://github.com/DevCycleHQ-Labs/example-ruby)

## Usage

// TODO

## Requirements

Docker

### Setup

* Create a `.env` file and set `DEVCYCLE_SERVER_SDK_KEY` to your Environment's SDK Key.\
You can find this under [Settings > Environments](https://app.devcycle.com/r/environments) on the DevCycle dashboard.
[Learn more about environments](https://docs.devcycle.com/essentials/environments).

### How to run the app

`docker build -t skip-controller-action-middleware . && docker run -p 8000:8000 skip-controller-action-middleware`

Runs the app in the development mode.\
Requests may be sent to http://localhost:8000

### License

This project is licensed under the MIT License.