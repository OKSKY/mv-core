# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: mv-core 1.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "mv-core"
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Valeriy Prokopchuk"]
  s.date = "2014-10-08"
  s.description = "Migration Validators project core classes"
  s.email = "vprokopchuk@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    "lib/migration_validators/active_record/base.rb",
    "lib/migration_validators/active_record/connection_adapters/abstract_adapter.rb",
    "lib/migration_validators/active_record/connection_adapters/native_adapter.rb",
    "lib/migration_validators/active_record/connection_adapters/table.rb",
    "lib/migration_validators/active_record/connection_adapters/table_definition.rb",
    "lib/migration_validators/active_record/migration.rb",
    "lib/migration_validators/active_record/schema.rb",
    "lib/migration_validators/active_record/schema_dumper.rb",
    "lib/migration_validators/adapters/base.rb",
    "lib/migration_validators/adapters/containers.rb",
    "lib/migration_validators/adapters/routing.rb",
    "lib/migration_validators/adapters/syntax.rb",
    "lib/migration_validators/adapters/validator_definitions.rb",
    "lib/migration_validators/core/adapter_wrapper.rb",
    "lib/migration_validators/core/db_validator.rb",
    "lib/migration_validators/core/statement_builder.rb",
    "lib/migration_validators/core/validator_constraints_list.rb",
    "lib/migration_validators/core/validator_container.rb",
    "lib/migration_validators/core/validator_definition.rb",
    "lib/migration_validators/core/validator_router.rb",
    "lib/mv-core.rb",
    "lib/options.rb"
  ]
  s.homepage = "http://github.com/vprokopchuk256/mv-core"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.1.10"
  s.summary = "Migration Validators project core classes"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>, [">= 4.1.6"])
      s.add_runtime_dependency(%q<activesupport>, [">= 4.1.6"])
      s.add_runtime_dependency(%q<i18n>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 2.0.1"])
      s.add_development_dependency(%q<sqlite3>, [">= 0"])
    else
      s.add_dependency(%q<activerecord>, [">= 4.1.6"])
      s.add_dependency(%q<activesupport>, [">= 4.1.6"])
      s.add_dependency(%q<i18n>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 2.0.1"])
      s.add_dependency(%q<sqlite3>, [">= 0"])
    end
  else
    s.add_dependency(%q<activerecord>, [">= 4.1.6"])
    s.add_dependency(%q<activesupport>, [">= 4.1.6"])
    s.add_dependency(%q<i18n>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 2.0.1"])
    s.add_dependency(%q<sqlite3>, [">= 0"])
  end
end
