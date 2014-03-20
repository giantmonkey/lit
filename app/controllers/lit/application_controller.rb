class Lit::ApplicationController < ApplicationController
  before_filter :authenticate
  before_filter :stop_hits_counter
  after_filter :restore_hits_counter

  layout :lit_layout

  private
    def lit_layout
      "lit/lit"
    end
    def authenticate
      if Lit.authentication_function.present?
        send(Lit.authentication_function)
      end
    end

    def stop_hits_counter
      Lit.init.cache.stop_hits_counter
    end

    def restore_hits_counter
      Lit.init.cache.restore_hits_counter
    end
end
