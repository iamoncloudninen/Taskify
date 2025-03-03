# frozen_string_literal: true

class CreateActiveStorageTables < ActiveRecord::Migration[5.2]
  def change
    create_active_storage_blobs_table
    create_active_storage_attachments
    create_active_storage_variant_records
  end

  private

  def create_active_storage_blobs_table
    create_table :active_storage_blobs do |t|
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

  def create_active_storage_attachments
    create_table :active_storage_attachments do |t|
      t.string     :name,     null: false
      t.references :record,   null: false, polymorphic: true
      t.references :blob,     null: false
      t.datetime   :created_at, null: false
    end
    add_index :active_storage_attachments, %i[record_type record_id name blob_id],
              name: 'index_active_storage_attachments_uniqueness', unique: true
  end

  def create_active_storage_variant_records
    create_table :active_storage_variant_records do |t|
      t.belongs_to :blob, null: false
      t.string :variation_digest, null: false
    end
    add_index :active_storage_variant_records, %i[blob_id variation_digest],
              name: 'index_active_storage_variant_records_uniqueness', unique: true
  end
end
