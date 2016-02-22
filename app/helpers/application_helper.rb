module ApplicationHelper
  def protocol
    RequestStore.store[:protocol]
  end

  def host
    RequestStore.store[:host]
  end

  def port
    RequestStore.store[:port] == 443 || RequestStore.store[:port] == 80 || RequestStore.store[:port].empty? ? "" : ":#{RequestStore.store[:port]}"
  end
end
