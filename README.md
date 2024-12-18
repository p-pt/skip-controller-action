# Skip Controller Action

This POC(Proof of concept) project leverages the use of DevCycle feature flags to skip necessary controller actions by either returning a specific JSON response or redirecting to a specific path.

notes: This POC project is built on top of [DevCycle Ruby Server SDK Example App](https://github.com/DevCycleHQ-Labs/example-ruby)

## Usage

For example, there is a bug in one of our APIs, say the /add-funds path, where existing feature flags won't be able to mitigate the issue. There might be massive impact until the deployment rollback is completed. The quickest way to immediately lower this impact is to skip the logic for the API, which is where the feature flag is being used here.

## Requirements

Docker

### Setup

#### 1. DevCycle Feature Flag

create a variable named `skip_controller_action_configs` with below variations:
```json
{
    "/test": {
        "handler": "render",
        "handler_attrs": {
            "type": "json",
            "value": {
                "status": "ok"
            }
        }
    },
    "/test?case=return_home": {
        "handler": "render",
        "handler_attrs": {
            "type": "template",
            "value": "hello/index"
        }
    },
    "/test?case=redirect": {
        "handler": "redirect",
        "handler_attrs": {
            "type": "relative_path",
            "value": "/redirect"
        }
    },
    "/test?case=incorrect_value": {
        "handler": "render",
        "handler_attrs": {
            "type": "unknown_type",
            "value": "unknown_value"
        }
    }
}
```
#### 2. Code

* Create a `.env` file and set `DEVCYCLE_SERVER_SDK_KEY` to your Environment's SDK Key.\
You can find this under [Settings > Environments](https://app.devcycle.com/r/environments) on the DevCycle dashboard.
[Learn more about environments](https://docs.devcycle.com/essentials/environments).

### How to run the app

`docker build -t skip-controller-action-middleware . && docker run -p 8000:8000 skip-controller-action-middleware`

Runs the app in the development mode.\
Requests may be sent to http://localhost:8000

### Demo

1. `http://localhost:8000/test`
    - return `{"status":"ok"}`

2. `http://localhost:8000/test?case=return_home`
    - render home template
    - <img src="https://github.com/user-attachments/assets/d71786f9-ba61-4e85-a1ab-f5fcc85463e8" width="400"/>

3. `http://localhost:8000/test?case=redirect`
    - return `{"message":"redirect success!"}`

4. `http://localhost:8000/test?case=incorrect_value`
    - return `{"message":"tested OK"}`
      -  due to incorrect `['handler_attrs']['type']` in the feature flag config

5. `http://localhost:8000/test?unknown`
    - return `{"message":"tested OK"}`
       - no handling is configured in the feature flag


### License

This project is licensed under the MIT License.