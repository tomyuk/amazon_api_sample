#
#
#
class InitializePostgresql < ActiveRecord::Migration
  def change

    reversible do |dir|
      dir.up do
        execute 'SET statement_timeout = 0'
        execute 'SET client_encoding = "UTF8"'
        execute 'SET standard_conforming_strings = on'
        execute 'SET check_function_bodies = false'
        execute 'SET client_min_messages = warning'
        execute 'SET search_path = public, pg_catalog'
        execute 'SET default_tablespace = \'\''
        execute 'SET default_with_oids = false'

        execute 'CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog'
        execute 'COMMENT ON EXTENSION plpgsql IS \'PL/pgSQL procedural language\''

        execute 'CREATE EXTENSION IF NOT EXISTS intarray'
        execute 'CREATE EXTENSION IF NOT EXISTS hstore'
        execute 'CREATE EXTENSION IF NOT EXISTS "uuid-ossp"'
      end

      dir.down do
        execute 'DROP EXTENSION hstore'
        execute 'DROP EXTENSION "uuid-ossp"'
      end
    end
  end
end
