module BeechServer::Models::Badges

  attr_accessor :badge

  def unearned_badges
    Badge.all - awards.includes(:badge).map(&:badge)
  end

  def deserves_badge?(badge)
    @badge = badge
    case @badge.badge_type
    when 'quantity'
      quantity_condition
    when 'one_of_each'
      one_of_each_condition
    when 'different'
      different_condition
    end
  end

  protected

  def badge_condition_params
    @badge.condition.split(':')
  end

  def quantity_condition
    type, target = badge_condition_params
    case type
    when 'any'
      beers.size >= badge.quantity
    when 'country'
      beers.where("country = ?", target).size >= badge.quantity
    when 'color'
      beers.joins(:beer_color)
        .where(beer_colors: {slug: target}).size >= badge.quantity
    when 'beer'
      beers.where('name = ?', target).size >= badge.quantity
    end
  end

  def one_of_each_condition
    type, target = badge_condition_params
    case type
    when 'color'
      target.split(',').all? do |color|
        beers.joins(:beer_color)
          .where(beer_colors: {slug: color}).any?
      end
    when 'beers'
      target.split(',').all? do |name|
        beers.where(name: name).any?
      end
    when 'countries'
      target.split(',').all? do |name|
        beers.where(country: name).any?
      end
    end
  end

  def different_condition
    type, target = badge_condition_params
    case type
    when 'beer'
      beers.size >= badge.quantity
    when 'country'
      beer_countries.size >= badge.quantity
    end
  end
end

