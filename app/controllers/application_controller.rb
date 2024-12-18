class ApplicationController < ActionController::Base
  before_action :setup_dev_cycle_config
  before_action :skip_controller_action

  private

  def setup_dev_cycle_config
    @dev_cycle_user = DevCycle::User.new({ user_id: "user_id_example" })
  end

  def skip_controller_action
    handle_response if should_skip_controller_action?
  end

  def should_skip_controller_action?
    @skip_controller_action_configs =
      DevCycleClient.variable_value(
        @dev_cycle_user,
        "skip_controller_action_configs",
        {},
      )

    @relative_path = request.fullpath # e.g. /test?case=return_home
    @skip_controller_action_configs[@relative_path].present?
  end

  def handle_response
    handler_data = @skip_controller_action_configs[@relative_path]
    @handler_attrs = handler_data["handler_attrs"]
    case handler_data["handler"]
    when "render"
      handle_render
    when "redirect"
      handle_redirect
    end
  end

  def handle_render
    case @handler_attrs["type"]
    when "json"
      render json: @handler_attrs["value"]
    when "template"
      render template: @handler_attrs["value"]
    else
      puts "[#{self.class}][#{__method__}] warn: invalid handler type"
    end
  end

  def handle_redirect
    case @handler_attrs["type"]
    when "relative_path"
      redirect_to @handler_attrs["value"]
    else
      puts "[#{self.class}][#{__method__}] warn: invalid handler type"
    end
  end
end
