module Util
  def valid_supplier_guid(supplier_guid)
    re = /[A-Za-z0-9_]+/
    match = re.match(supplier_guid)
    return !match.nil?
  end
end
