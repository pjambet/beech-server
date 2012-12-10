module BeechServer::Models::Badges

  def unearned_badges
    Badge.all - awards.includes(:badge).map(&:badge)
  end

  def deserve_badge?(badge)
    case badge.type
    when 'quantity'
      type, target = badge.condition.split(':')
      case type
      when 'country'
        beers.where("#{type} = ?", target).size >= badge.quantity
      when 'color'
        beers.joins(:beer_color)
             .where(beer_colors: {slug: target}).size >= badge.quantity
      when 'beer'
        beers.where('name = ?', target).size >= badge.quantity
      else
        false
      end
    else
      false
    end
  end

end

