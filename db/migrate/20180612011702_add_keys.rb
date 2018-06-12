class AddKeys < ActiveRecord::Migration
  def change
    add_foreign_key "answers", "questions", name: "answers_question_id_fk"
    add_foreign_key "answers", "users", name: "answers_user_id_fk"
    add_foreign_key "appointments", "users", column: "buyer_id", name: "appointments_buyer_id_fk"
    add_foreign_key "appointments", "conversations", name: "appointments_conversation_id_fk"
    add_foreign_key "appointments", "vehicles", name: "appointments_vehicle_id_fk"
    add_foreign_key "autopart_photos", "autoparts", name: "autopart_photos_autopart_id_fk"
    add_foreign_key "purchases_upgrades", "purchases", name: "purchases_upgrades_purchase_id_fk"
    add_foreign_key "purchases_upgrades", "upgrades", name: "purchases_upgrades_upgrade_id_fk"
  end
end
