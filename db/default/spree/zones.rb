  bolivia = Spree::Zone.where(name: 'Bolivia', description: 'Zona de actividad de Caimango', kind: 'state').first_or_create!

['Santa Cruz', 'La Paz', 'Cochabamba'].each do |name|
  bolivia.zone_members.where(zoneable: Spree::State.find_by!(name: name)).first_or_create!
end