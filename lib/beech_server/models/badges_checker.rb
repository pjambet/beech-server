module BeechServer::Models::BadgesChecker

  attr_accessor :badge

  def unearned_badges
    Badge.all - awards.includes(:badge).map(&:badge)
  end

  def deserves_badge?(badge)
    checker = RegularBadgeChecker.create_badge badge, self
    checker.check
  end

  class RegularBadgeChecker

    attr_reader :badge, :user

    class << self
      def create_badge(badge, user)
        cst_name = "#{badge.badge_type}_badge_checker".camelize
        cst_prefix = "BeechServer::Models::BadgesChecker::"
        "#{cst_prefix}#{cst_name}".constantize.new badge, user
      end
    end

    def initialize(badge, user)
      @badge = badge
      @user = user
    end

    def badge_condition_params
      badge.condition.split(':')
    end
  end

  class QuantityBadgeChecker < RegularBadgeChecker
    def check
      type, target = badge_condition_params
      case type
      when 'any'
        user.beers.size >= badge.quantity
      when 'country'
        user.beers.where("country = ?", target).size >= badge.quantity
      when 'color'
        user.beers.joins(:beer_color)
          .where(beer_colors: {slug: target}).size >= badge.quantity
      when 'beer'
        user.beers.where('name = ?', target).size >= badge.quantity
      end
    end
  end

  class OneOfEachBadgeChecker < RegularBadgeChecker
    def check
      type, target = badge_condition_params
      targets = target.split(',')
      case type
      when 'color'
        targets.all? do |color|
          user.beers.joins(:beer_color)
            .where(beer_colors: {slug: color}).any?
        end
      when 'beers'
        targets.all? do |name|
          user.beers.where(name: name).any?
        end
      when 'countries'
        targets.all? do |name|
          user.beers.where(country: name).any?
        end
      end
    end
  end

  class DifferentBadgeChecker < RegularBadgeChecker
    def check
      type, target = badge_condition_params
      different_condition_mapping(type).size >= badge.quantity
    end

    def different_condition_mapping(type)
      mapping = {beer: :beers, country: :beer_countries}
      user.send mapping[type.intern]
    end
  end

end

