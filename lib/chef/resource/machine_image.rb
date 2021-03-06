require 'chef/resource/lwrp_base'
require 'cheffish'
require 'chef_metal'
require 'cheffish/merged_config'

class Chef::Resource::MachineImage < Chef::Resource::Machine
  self.resource_name = 'machine_image'

  def initialize(*args)
    super
    @image_options = run_context.chef_metal.current_image_options
    @machine_options = run_context.chef_metal.current_machine_options
  end

  # TODO check if we still have all the actions from machine
  actions :create, :destroy, :archive
  default_action :create

  attribute :image_options, :kind_of => Hash

  # TODO
  # - policy for old version cleanup
  # - when attributes or recipes of the machine_image changes, or when the actual
  #   recipes therein change, we will regenerate the image
  # - attribute to force or turn off image updates
  # - ability to rebuild new image based on the previous image
  # - ability to specify whether and how to keep the image-building machine around
  # - ability to specify whether to leave the chef config around or not
end
