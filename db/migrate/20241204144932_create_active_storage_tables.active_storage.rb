# frozen_string_literal: true

class CreateActiveStorageTables < ActiveRecord::Migration[5.2]
  def change
    primary_key_type, foreign_key_type = determine_key_types

    create_active_storage_blobs_table(primary_key_type)
    create_active_storage_attachments(foreign_key_type)
    create_active_storage_variant_records(foreign_key_type)
  end

  private

  def create_active_storage_blobs_table(primary_key_type)
    create_table :active_storage_blobs, id: primary_key_type do |t|
      t.string   :key,          null: false
      t.string   :filename,     null: false
      t.string   :content_type
      t.text     :metadata
      t.string   :service_name, null: false
      t.bigint   :byte_size,    null: false
      t.string   :checksum,     null: false
      t.datetime :created_at,   null: false
    end
    add_index :active_storage_blobs, [:key], unique: true
  end

  def create_active_storage_attachments(foreign_key_type)
    create_table :active_storage_attachments, id: primary_key_type do |t|
      t.string     :name,     null: false
      t.references :record,   null: false, polymorphic: true, type: foreign_key_type
      t.references :blob,     null: false, type: foreign_key_type
      t.datetime   :created_at, null: false
    end
    add_index :active_storage_attachments, %i[record_type record_id name blob_id],
              name: 'index_active_storage_attachments_uniqueness', unique: true
  end

  def create_active_storage_variant_records(foreign_key_type)
    create_table :active_storage_variant_records, id: primary_key_type do |t|
      t.belongs_to :blob, null: false, type: foreign_key_type
      t.string :variation_digest, null: false
    end
    add_index :active_storage_variant_records, %i[blob_id variation_digest],
              name: 'index_active_storage_variant_records_uniqueness', unique: true
  end

  def determine_key_types
    primary_key_type = Rails.configuration.generators.options.dig(:active_record, :primary_key_type) || :bigint
    foreign_key_type = primary_key_type
    [primary_key_type, foreign_key_type]
  end
end
