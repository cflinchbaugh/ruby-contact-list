require "test_helper"

class JwtDenylistTest < ActiveSupport::TestCase
  def setup
    @jti = SecureRandom.uuid  # Generate a fake JTI (JWT ID)
    @exp = Time.now.to_i + 3600  # Token expiration 1 hour from now
  end

  test "should create a revoked JWT entry" do
    denylist_entry = JwtDenylist.create!(jti: @jti, exp: @exp)
    assert denylist_entry.persisted?, "JwtDenylist entry should be saved"
  end

  test "should find a revoked token by JTI" do
    JwtDenylist.create!(jti: @jti, exp: @exp)
    assert JwtDenylist.exists?(jti: @jti), "Revoked token should exist in denylist"
  end

  test "should not find a non-revoked token" do
    assert_not JwtDenylist.exists?(jti: "nonexistent-jti"), "Non-revoked token should not be found"
  end

  test "should be mapped to the correct database table" do
    assert_equal "jwt_denylist", JwtDenylist.table_name, "Table name should be 'jwt_denylist'"
  end
end
