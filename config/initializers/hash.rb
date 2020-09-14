# reference: ~/.rvm/gems/ruby-2.6.3/gems/activesupport-6.0.3.2/lib/active_support/core_ext/hash/reveerse_merge.rb

class Hash
  def reverse_deep_merge(other_hash)
    other_hash.deep_merge(self)
  end

  def reverse_deep_merge!(other_hash)
    replace(reverse_deep_merge(other_hash))
  end
end
