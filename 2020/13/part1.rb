depart  = @data.first.strip.to_i
bus_ids = @data.first.strip.split(',').map(&:to_i).reject(&:zero?)

id, bus_departure = bus_ids
  .map { |id| [id, ((depart / id) + 1) * id]  }
  .min_by(&:last)

@output = (bus_departure - depart) * id
