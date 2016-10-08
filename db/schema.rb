# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160926000606) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "intarray"
  enable_extension "hstore"
  enable_extension "uuid-ossp"

  create_table "damage_tables", force: :cascade do |t|
    t.integer  "min",        default: 0, null: false
    t.integer  "max",        default: 0, null: false
    t.integer  "damages",    default: 0, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "invoices", force: :cascade do |t|
    t.string   "shop",       default: "",  null: false
    t.string   "order_id",   default: "",  null: false
    t.string   "ship_to",    default: "",  null: false
    t.string   "phone",      default: "",  null: false
    t.integer  "price",      default: 0,   null: false
    t.float    "rate",       default: 1.0, null: false
    t.integer  "damages",    default: 0,   null: false
    t.datetime "ordered_at"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "invoices", ["ship_to"], name: "index_invoices_on_ship_to", using: :btree
  add_index "invoices", ["shop", "order_id"], name: "index_invoices_on_shop_and_order_id", unique: true, using: :btree

# Could not dump table "pg_aggregate" because of following StandardError
#   Unknown type 'regproc' for column 'aggfnoid'

# Could not dump table "pg_am" because of following StandardError
#   Unknown type 'regproc' for column 'aminsert'

  create_table "pg_amop", id: false, force: :cascade do |t|
    t.integer "amopfamily",               null: false
    t.integer "amoplefttype",             null: false
    t.integer "amoprighttype",            null: false
    t.integer "amopstrategy",   limit: 2, null: false
    t.string  "amoppurpose",              null: false
    t.integer "amopopr",                  null: false
    t.integer "amopmethod",               null: false
    t.integer "amopsortfamily",           null: false
  end

  add_index "pg_amop", ["amopfamily", "amoplefttype", "amoprighttype", "amopstrategy"], name: "pg_amop_fam_strat_index", unique: true, using: :btree
  add_index "pg_amop", ["amopopr", "amoppurpose", "amopfamily"], name: "pg_amop_opr_fam_index", unique: true, using: :btree
  add_index "pg_amop", ["oid"], name: "pg_amop_oid_index", unique: true, using: :btree

# Could not dump table "pg_amproc" because of following StandardError
#   Unknown type 'regproc' for column 'amproc'

# Could not dump table "pg_attrdef" because of following StandardError
#   Unknown type 'pg_node_tree' for column 'adbin'

# Could not dump table "pg_attribute" because of following StandardError
#   Unknown type 'aclitem' for column 'attacl'

  create_table "pg_auth_members", id: false, force: :cascade do |t|
    t.integer "roleid",       null: false
    t.integer "member",       null: false
    t.integer "grantor",      null: false
    t.boolean "admin_option", null: false
  end

  add_index "pg_auth_members", ["member", "roleid"], name: "pg_auth_members_member_role_index", unique: true, using: :btree
  add_index "pg_auth_members", ["roleid", "member"], name: "pg_auth_members_role_member_index", unique: true, using: :btree

  create_table "pg_authid", id: false, force: :cascade do |t|
    t.string   "rolname",        null: false
    t.boolean  "rolsuper",       null: false
    t.boolean  "rolinherit",     null: false
    t.boolean  "rolcreaterole",  null: false
    t.boolean  "rolcreatedb",    null: false
    t.boolean  "rolcatupdate",   null: false
    t.boolean  "rolcanlogin",    null: false
    t.boolean  "rolreplication", null: false
    t.integer  "rolconnlimit",   null: false
    t.text     "rolpassword"
    t.datetime "rolvaliduntil"
  end

  add_index "pg_authid", ["oid"], name: "pg_authid_oid_index", unique: true, using: :btree
  add_index "pg_authid", ["rolname"], name: "pg_authid_rolname_index", unique: true, using: :btree

  create_table "pg_cast", id: false, force: :cascade do |t|
    t.integer "castsource",  null: false
    t.integer "casttarget",  null: false
    t.integer "castfunc",    null: false
    t.string  "castcontext", null: false
    t.string  "castmethod",  null: false
  end

  add_index "pg_cast", ["castsource", "casttarget"], name: "pg_cast_source_target_index", unique: true, using: :btree
  add_index "pg_cast", ["oid"], name: "pg_cast_oid_index", unique: true, using: :btree

# Could not dump table "pg_class" because of following StandardError
#   Unknown type 'xid' for column 'relfrozenxid'

  create_table "pg_collation", id: false, force: :cascade do |t|
    t.string  "collname",      null: false
    t.integer "collnamespace", null: false
    t.integer "collowner",     null: false
    t.integer "collencoding",  null: false
    t.string  "collcollate",   null: false
    t.string  "collctype",     null: false
  end

  add_index "pg_collation", ["collname", "collencoding", "collnamespace"], name: "pg_collation_name_enc_nsp_index", unique: true, using: :btree
  add_index "pg_collation", ["oid"], name: "pg_collation_oid_index", unique: true, using: :btree

# Could not dump table "pg_constraint" because of following StandardError
#   Unknown type 'pg_node_tree' for column 'conbin'

# Could not dump table "pg_conversion" because of following StandardError
#   Unknown type 'regproc' for column 'conproc'

# Could not dump table "pg_database" because of following StandardError
#   Unknown type 'xid' for column 'datfrozenxid'

  create_table "pg_db_role_setting", id: false, force: :cascade do |t|
    t.integer "setdatabase", null: false
    t.integer "setrole",     null: false
    t.text    "setconfig",                array: true
  end

  add_index "pg_db_role_setting", ["setdatabase", "setrole"], name: "pg_db_role_setting_databaseid_rol_index", unique: true, using: :btree

# Could not dump table "pg_default_acl" because of following StandardError
#   Unknown type 'aclitem' for column 'defaclacl'

  create_table "pg_depend", id: false, force: :cascade do |t|
    t.integer "classid",     null: false
    t.integer "objid",       null: false
    t.integer "objsubid",    null: false
    t.integer "refclassid",  null: false
    t.integer "refobjid",    null: false
    t.integer "refobjsubid", null: false
    t.string  "deptype",     null: false
  end

  add_index "pg_depend", ["classid", "objid", "objsubid"], name: "pg_depend_depender_index", using: :btree
  add_index "pg_depend", ["refclassid", "refobjid", "refobjsubid"], name: "pg_depend_reference_index", using: :btree

  create_table "pg_description", id: false, force: :cascade do |t|
    t.integer "objoid",      null: false
    t.integer "classoid",    null: false
    t.integer "objsubid",    null: false
    t.text    "description"
  end

  add_index "pg_description", ["objoid", "classoid", "objsubid"], name: "pg_description_o_c_o_index", unique: true, using: :btree

  create_table "pg_enum", id: false, force: :cascade do |t|
    t.integer "enumtypid",     null: false
    t.float   "enumsortorder", null: false
    t.string  "enumlabel",     null: false
  end

  add_index "pg_enum", ["enumtypid", "enumlabel"], name: "pg_enum_typid_label_index", unique: true, using: :btree
  add_index "pg_enum", ["enumtypid", "enumsortorder"], name: "pg_enum_typid_sortorder_index", unique: true, using: :btree
  add_index "pg_enum", ["oid"], name: "pg_enum_oid_index", unique: true, using: :btree

  create_table "pg_event_trigger", id: false, force: :cascade do |t|
    t.string  "evtname",    null: false
    t.string  "evtevent",   null: false
    t.integer "evtowner",   null: false
    t.integer "evtfoid",    null: false
    t.string  "evtenabled", null: false
    t.text    "evttags",                 array: true
  end

  add_index "pg_event_trigger", ["evtname"], name: "pg_event_trigger_evtname_index", unique: true, using: :btree
  add_index "pg_event_trigger", ["oid"], name: "pg_event_trigger_oid_index", unique: true, using: :btree

  create_table "pg_extension", id: false, force: :cascade do |t|
    t.string  "extname",        null: false
    t.integer "extowner",       null: false
    t.integer "extnamespace",   null: false
    t.boolean "extrelocatable", null: false
    t.text    "extversion"
    t.integer "extconfig",                   array: true
    t.text    "extcondition",                array: true
  end

  add_index "pg_extension", ["extname"], name: "pg_extension_name_index", unique: true, using: :btree
  add_index "pg_extension", ["oid"], name: "pg_extension_oid_index", unique: true, using: :btree

# Could not dump table "pg_foreign_data_wrapper" because of following StandardError
#   Unknown type 'aclitem' for column 'fdwacl'

# Could not dump table "pg_foreign_server" because of following StandardError
#   Unknown type 'aclitem' for column 'srvacl'

  create_table "pg_foreign_table", id: false, force: :cascade do |t|
    t.integer "ftrelid",   null: false
    t.integer "ftserver",  null: false
    t.text    "ftoptions",              array: true
  end

  add_index "pg_foreign_table", ["ftrelid"], name: "pg_foreign_table_relid_index", unique: true, using: :btree

# Could not dump table "pg_index" because of following StandardError
#   Unknown type 'int2vector' for column 'indkey'

  create_table "pg_inherits", id: false, force: :cascade do |t|
    t.integer "inhrelid",  null: false
    t.integer "inhparent", null: false
    t.integer "inhseqno",  null: false
  end

  add_index "pg_inherits", ["inhparent"], name: "pg_inherits_parent_index", using: :btree
  add_index "pg_inherits", ["inhrelid", "inhseqno"], name: "pg_inherits_relid_seqno_index", unique: true, using: :btree

# Could not dump table "pg_language" because of following StandardError
#   Unknown type 'aclitem' for column 'lanacl'

  create_table "pg_largeobject", id: false, force: :cascade do |t|
    t.integer "loid",   null: false
    t.integer "pageno", null: false
    t.binary  "data"
  end

  add_index "pg_largeobject", ["loid", "pageno"], name: "pg_largeobject_loid_pn_index", unique: true, using: :btree

# Could not dump table "pg_largeobject_metadata" because of following StandardError
#   Unknown type 'aclitem' for column 'lomacl'

# Could not dump table "pg_namespace" because of following StandardError
#   Unknown type 'aclitem' for column 'nspacl'

  create_table "pg_opclass", id: false, force: :cascade do |t|
    t.integer "opcmethod",    null: false
    t.string  "opcname",      null: false
    t.integer "opcnamespace", null: false
    t.integer "opcowner",     null: false
    t.integer "opcfamily",    null: false
    t.integer "opcintype",    null: false
    t.boolean "opcdefault",   null: false
    t.integer "opckeytype",   null: false
  end

  add_index "pg_opclass", ["oid"], name: "pg_opclass_oid_index", unique: true, using: :btree
  add_index "pg_opclass", ["opcmethod", "opcname", "opcnamespace"], name: "pg_opclass_am_name_nsp_index", unique: true, using: :btree

# Could not dump table "pg_operator" because of following StandardError
#   Unknown type 'regproc' for column 'oprcode'

  create_table "pg_opfamily", id: false, force: :cascade do |t|
    t.integer "opfmethod",    null: false
    t.string  "opfname",      null: false
    t.integer "opfnamespace", null: false
    t.integer "opfowner",     null: false
  end

  add_index "pg_opfamily", ["oid"], name: "pg_opfamily_oid_index", unique: true, using: :btree
  add_index "pg_opfamily", ["opfmethod", "opfname", "opfnamespace"], name: "pg_opfamily_am_name_nsp_index", unique: true, using: :btree

# Could not dump table "pg_pltemplate" because of following StandardError
#   Unknown type 'aclitem' for column 'tmplacl'

# Could not dump table "pg_proc" because of following StandardError
#   Unknown type 'regproc' for column 'protransform'

# Could not dump table "pg_range" because of following StandardError
#   Unknown type 'regproc' for column 'rngcanonical'

# Could not dump table "pg_rewrite" because of following StandardError
#   Unknown type 'pg_node_tree' for column 'ev_qual'

  create_table "pg_seclabel", id: false, force: :cascade do |t|
    t.integer "objoid",   null: false
    t.integer "classoid", null: false
    t.integer "objsubid", null: false
    t.text    "provider"
    t.text    "label"
  end

  add_index "pg_seclabel", ["objoid", "classoid", "objsubid", "provider"], name: "pg_seclabel_object_index", unique: true, using: :btree

  create_table "pg_shdepend", id: false, force: :cascade do |t|
    t.integer "dbid",       null: false
    t.integer "classid",    null: false
    t.integer "objid",      null: false
    t.integer "objsubid",   null: false
    t.integer "refclassid", null: false
    t.integer "refobjid",   null: false
    t.string  "deptype",    null: false
  end

  add_index "pg_shdepend", ["dbid", "classid", "objid", "objsubid"], name: "pg_shdepend_depender_index", using: :btree
  add_index "pg_shdepend", ["refclassid", "refobjid"], name: "pg_shdepend_reference_index", using: :btree

  create_table "pg_shdescription", id: false, force: :cascade do |t|
    t.integer "objoid",      null: false
    t.integer "classoid",    null: false
    t.text    "description"
  end

  add_index "pg_shdescription", ["objoid", "classoid"], name: "pg_shdescription_o_c_index", unique: true, using: :btree

  create_table "pg_shseclabel", id: false, force: :cascade do |t|
    t.integer "objoid",   null: false
    t.integer "classoid", null: false
    t.text    "provider"
    t.text    "label"
  end

  add_index "pg_shseclabel", ["objoid", "classoid", "provider"], name: "pg_shseclabel_object_index", unique: true, using: :btree

# Could not dump table "pg_statistic" because of following StandardError
#   Unknown type 'anyarray' for column 'stavalues1'

# Could not dump table "pg_tablespace" because of following StandardError
#   Unknown type 'aclitem' for column 'spcacl'

# Could not dump table "pg_trigger" because of following StandardError
#   Unknown type 'int2vector' for column 'tgattr'

  create_table "pg_ts_config", id: false, force: :cascade do |t|
    t.string  "cfgname",      null: false
    t.integer "cfgnamespace", null: false
    t.integer "cfgowner",     null: false
    t.integer "cfgparser",    null: false
  end

  add_index "pg_ts_config", ["cfgname", "cfgnamespace"], name: "pg_ts_config_cfgname_index", unique: true, using: :btree
  add_index "pg_ts_config", ["oid"], name: "pg_ts_config_oid_index", unique: true, using: :btree

  create_table "pg_ts_config_map", id: false, force: :cascade do |t|
    t.integer "mapcfg",       null: false
    t.integer "maptokentype", null: false
    t.integer "mapseqno",     null: false
    t.integer "mapdict",      null: false
  end

  add_index "pg_ts_config_map", ["mapcfg", "maptokentype", "mapseqno"], name: "pg_ts_config_map_index", unique: true, using: :btree

  create_table "pg_ts_dict", id: false, force: :cascade do |t|
    t.string  "dictname",       null: false
    t.integer "dictnamespace",  null: false
    t.integer "dictowner",      null: false
    t.integer "dicttemplate",   null: false
    t.text    "dictinitoption"
  end

  add_index "pg_ts_dict", ["dictname", "dictnamespace"], name: "pg_ts_dict_dictname_index", unique: true, using: :btree
  add_index "pg_ts_dict", ["oid"], name: "pg_ts_dict_oid_index", unique: true, using: :btree

# Could not dump table "pg_ts_parser" because of following StandardError
#   Unknown type 'regproc' for column 'prsstart'

# Could not dump table "pg_ts_template" because of following StandardError
#   Unknown type 'regproc' for column 'tmplinit'

# Could not dump table "pg_type" because of following StandardError
#   Unknown type 'regproc' for column 'typinput'

  create_table "pg_user_mapping", id: false, force: :cascade do |t|
    t.integer "umuser",    null: false
    t.integer "umserver",  null: false
    t.text    "umoptions",              array: true
  end

  add_index "pg_user_mapping", ["oid"], name: "pg_user_mapping_oid_index", unique: true, using: :btree
  add_index "pg_user_mapping", ["umuser", "umserver"], name: "pg_user_mapping_user_server_index", unique: true, using: :btree

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "settings", force: :cascade do |t|
    t.string   "ems_login",    default: "", null: false
    t.string   "ems_password", default: "", null: false
    t.string   "content",      default: "", null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "system_logs", force: :cascade do |t|
    t.string   "event",      default: "", null: false
    t.string   "client",     default: "", null: false
    t.string   "browser",    default: "", null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

end
