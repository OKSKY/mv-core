# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: mv-core 2.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "mv-core"
  s.version = "2.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Valeriy Prokopchuk"]
  s.date = "2015-01-28"
  s.description = "DB constraints in migrations similiar to ActiveRecord validations. Core classes"
  s.email = "vprokopchuk@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    "lib/mv-core.rb",
    "lib/mv/core/active_record/base_decorator.rb",
    "lib/mv/core/active_record/connection_adapters/abstract_adapter_decorator.rb",
    "lib/mv/core/active_record/connection_adapters/table_decorator.rb",
    "lib/mv/core/active_record/connection_adapters/table_definition_decorator.rb",
    "lib/mv/core/active_record/migration/command_recorder_decorator.rb",
    "lib/mv/core/active_record/migration_decorator.rb",
    "lib/mv/core/active_record/schema_decorator.rb",
    "lib/mv/core/active_record/schema_dumper_decorator.rb",
    "lib/mv/core/constraint/base.rb",
    "lib/mv/core/constraint/builder/base.rb",
    "lib/mv/core/constraint/builder/factory.rb",
    "lib/mv/core/constraint/builder/index.rb",
    "lib/mv/core/constraint/builder/trigger.rb",
    "lib/mv/core/constraint/description.rb",
    "lib/mv/core/constraint/factory.rb",
    "lib/mv/core/constraint/index.rb",
    "lib/mv/core/constraint/trigger.rb",
    "lib/mv/core/db/helpers/column_validators.rb",
    "lib/mv/core/db/helpers/table_validators.rb",
    "lib/mv/core/db/migration_validator.rb",
    "lib/mv/core/error.rb",
    "lib/mv/core/migration/base.rb",
    "lib/mv/core/migration/operations/add_column.rb",
    "lib/mv/core/migration/operations/change_column.rb",
    "lib/mv/core/migration/operations/drop_table.rb",
    "lib/mv/core/migration/operations/factory.rb",
    "lib/mv/core/migration/operations/list.rb",
    "lib/mv/core/migration/operations/remove_column.rb",
    "lib/mv/core/migration/operations/rename_column.rb",
    "lib/mv/core/migration/operations/rename_table.rb",
    "lib/mv/core/presenter/constraint/description.rb",
    "lib/mv/core/presenter/validation/base.rb",
    "lib/mv/core/railtie.rb",
    "lib/mv/core/route/base.rb",
    "lib/mv/core/route/index.rb",
    "lib/mv/core/route/trigger.rb",
    "lib/mv/core/router.rb",
    "lib/mv/core/services/compare_constraint_arrays.rb",
    "lib/mv/core/services/compare_constraints.rb",
    "lib/mv/core/services/create_constraints.rb",
    "lib/mv/core/services/create_migration_validators_table.rb",
    "lib/mv/core/services/delete_constraints.rb",
    "lib/mv/core/services/load_constraints.rb",
    "lib/mv/core/services/parse_validation_options.rb",
    "lib/mv/core/services/say_constraints_diff.rb",
    "lib/mv/core/services/show_constraints.rb",
    "lib/mv/core/services/synchronize_constraints.rb",
    "lib/mv/core/services/uninstall.rb",
    "lib/mv/core/validation/absence.rb",
    "lib/mv/core/validation/active_model_presenter/absence.rb",
    "lib/mv/core/validation/active_model_presenter/base.rb",
    "lib/mv/core/validation/active_model_presenter/exclusion.rb",
    "lib/mv/core/validation/active_model_presenter/factory.rb",
    "lib/mv/core/validation/active_model_presenter/inclusion.rb",
    "lib/mv/core/validation/active_model_presenter/length.rb",
    "lib/mv/core/validation/active_model_presenter/presence.rb",
    "lib/mv/core/validation/active_model_presenter/uniqueness.rb",
    "lib/mv/core/validation/base.rb",
    "lib/mv/core/validation/builder/absence.rb",
    "lib/mv/core/validation/builder/base.rb",
    "lib/mv/core/validation/builder/custom.rb",
    "lib/mv/core/validation/builder/exclusion.rb",
    "lib/mv/core/validation/builder/factory.rb",
    "lib/mv/core/validation/builder/inclusion.rb",
    "lib/mv/core/validation/builder/length.rb",
    "lib/mv/core/validation/builder/presence.rb",
    "lib/mv/core/validation/builder/uniqueness.rb",
    "lib/mv/core/validation/custom.rb",
    "lib/mv/core/validation/exclusion.rb",
    "lib/mv/core/validation/factory.rb",
    "lib/mv/core/validation/inclusion.rb",
    "lib/mv/core/validation/length.rb",
    "lib/mv/core/validation/presence.rb",
    "lib/mv/core/validation/uniqueness.rb",
    "lib/mv/core/validators/array_validator.rb",
    "lib/mv/core/validators/integers_array_validator.rb",
    "lib/mv/core/validators/valid_validator.rb"
  ]
  s.homepage = "http://github.com/vprokopchuk256/mv-core"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0")
  s.rubygems_version = "2.4.4"
  s.summary = "DB constraints in migrations similiar to ActiveRecord validations. Core classes"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<railties>, ["~> 4.1"])
      s.add_runtime_dependency(%q<activerecord>, ["~> 4.1"])
      s.add_runtime_dependency(%q<i18n>, ["~> 0.7"])
      s.add_development_dependency(%q<jeweler>, ["~> 2.0"])
      s.add_development_dependency(%q<sqlite3>, ["~> 1.3"])
      s.add_development_dependency(%q<guard-rspec>, ["~> 4.5"])
      s.add_development_dependency(%q<rspec>, ["~> 3.1"])
      s.add_development_dependency(%q<rspec-its>, ["~> 1.1"])
      s.add_development_dependency(%q<shoulda>, ["~> 3.5"])
      s.add_development_dependency(%q<factory_girl>, ["~> 4.5"])
      s.add_development_dependency(%q<coveralls>, ["~> 0.7"])
    else
      s.add_dependency(%q<railties>, ["~> 4.1"])
      s.add_dependency(%q<activerecord>, ["~> 4.1"])
      s.add_dependency(%q<i18n>, ["~> 0.7"])
      s.add_dependency(%q<jeweler>, ["~> 2.0"])
      s.add_dependency(%q<sqlite3>, ["~> 1.3"])
      s.add_dependency(%q<guard-rspec>, ["~> 4.5"])
      s.add_dependency(%q<rspec>, ["~> 3.1"])
      s.add_dependency(%q<rspec-its>, ["~> 1.1"])
      s.add_dependency(%q<shoulda>, ["~> 3.5"])
      s.add_dependency(%q<factory_girl>, ["~> 4.5"])
      s.add_dependency(%q<coveralls>, ["~> 0.7"])
    end
  else
    s.add_dependency(%q<railties>, ["~> 4.1"])
    s.add_dependency(%q<activerecord>, ["~> 4.1"])
    s.add_dependency(%q<i18n>, ["~> 0.7"])
    s.add_dependency(%q<jeweler>, ["~> 2.0"])
    s.add_dependency(%q<sqlite3>, ["~> 1.3"])
    s.add_dependency(%q<guard-rspec>, ["~> 4.5"])
    s.add_dependency(%q<rspec>, ["~> 3.1"])
    s.add_dependency(%q<rspec-its>, ["~> 1.1"])
    s.add_dependency(%q<shoulda>, ["~> 3.5"])
    s.add_dependency(%q<factory_girl>, ["~> 4.5"])
    s.add_dependency(%q<coveralls>, ["~> 0.7"])
  end
end

