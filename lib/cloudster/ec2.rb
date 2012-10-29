module Cloudster
  #==Ec2 resource
  class Ec2

    # Initialize an Ec2 instance
    #
    # ==== Notes
    # options parameter must include values for :name, :key_name and :image_id
    #
    # ==== Examples
    #   ec2 = Cloudster::Ec2.new(
    #    :name => 'AppServer',
    #    :key_name => 'mykey',
    #    :image_id => 'ami_image_id',
    #    :instance_type => 't1.micro'
    #   )
    #
    # ==== Parameters
    # * options<~Hash> - 
    #     * :name: String containing the name for the Ec2 resource
    #     * :key_name: String containing the name of the keypair to be used for SSH
    #     * :image_id: String containing the AMI image id to be used while creating the Ec2 resource
    #     * :instance_type: String containing instance type ( Example : t1.micro )
    def initialize(options = {})
      require_options(options, [:name, :key_name, :image_id])
      @name = options[:name]
      @key_name = options[:key_name]
      @image_id = options[:image_id]
      @instance_type = options[:instance_type]
    end

    # Returns a Ruby hash version of the Cloud Formation template for the resource instance
    #
    # ==== Examples
    #   ec2 = Cloudster::Ec2.new(
    #    :name => 'AppServer',
    #    :key_name => 'mykey',
    #    :image_id => 'ami_image_id',
    #    :instance_type => 't1.micro'
    #   )
    #   ec2.template
    #
    # ==== Returns
    # * Ruby hash version of the Cloud Formation template for the resource instance
    def template
      Ec2.template({:name =>@name, :key_name => @key_name, :image_id => @image_id, :instance_type => @instance_type})
    end

    # Class method that returns a Ruby hash version of the Cloud Formation template
    #
    # ==== Examples
    #   template = Cloudster::Ec2.template(
    #    :name => 'AppServer',
    #    :key_name => 'mykey',
    #    :image_id => 'ami_image_id',
    #    :instance_type => 't1.micro'
    #   )
    #
    # ==== Parameters
    # * options<~Hash> - 
    #   *Keys: 
    #     * :name: String containing the name for the Ec2 resource
    #     * :key_name: String containing the name of the keypair to be used for SSH
    #     * :image_id: String containing the AMI image id to be used while creating the Ec2 resource
    #     * :instance_type: String containing instance type ( Example : t1.micro )
    #
    # ==== Returns
    # * Ruby hash version of the Cloud Formation template
    def self.template(options = {})
      require_options(options, [:name, :key_name, :image_id])
      properties = {}
      properties.merge!({"KeyName" => options[:key_name], "ImageId" => options[:image_id]})
      properties.merge!({"InstanceType" => options[:instance_type]}) unless options[:instance_type].nil?
      template = {'Resources' => { 
                        options[:name] => { 
                          'Type' => 'AWS::EC2::Instance',
                          'Properties' => properties
                       }
                  }
      }
      return template 
    end

  end
end
