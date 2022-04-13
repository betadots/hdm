require 'test_helper'

class NodeTest < ActiveSupport::TestCase
  test "list the nodes" do
    assert_equal ["1m73otky.betadots.training", "1tge1wo3.betadots.training", "2288jh8e.betadots.training", "33amc5da.betadots.training", "3ay66ymd.betadots.training", "3bx5fygw.betadots.training", "3i8rrqjx.betadots.training", "3io2n5uh.betadots.training", "3q8ync63.betadots.training", "40sbev55.betadots.training", "4eexoda7.betadots.training", "4jjfyx1h.betadots.training", "5gfpx2k7.betadots.training", "5gv8l8n3.betadots.training", "5npv7v50.betadots.training", "5ruwuuad.betadots.training", "6mlkoauf.betadots.training", "724pbcao.betadots.training", "7jb746rk.betadots.training", "7wdm4xss.betadots.training", "8byzjpzz.betadots.training", "8drk73w4.betadots.training", "8yfl7kiv.betadots.training", "9cvpd0wq.betadots.training", "a2st4ipx.betadots.training", "arbpv4us.betadots.training", "arcnlzkm.betadots.training", "b3pcqavv.betadots.training", "b4739ubj.betadots.training", "bzuvus9e.betadots.training", "cn32iom0.betadots.training", "cuar01ep.betadots.training", "dbrn3h2r.betadots.training", "dhplrtv.betadots.training", "dmk15880.betadots.training", "dmpp0nom.betadots.training", "e5ujans9.betadots.training", "eerukb8k.betadots.training", "eztmlf24.betadots.training", "fefo79a7.betadots.training", "fj2yfmw.betadots.training", "fnp4tnay.betadots.training", "g39gaasx.betadots.training", "gki2r2ip.betadots.training", "gtlhhexp.betadots.training", "guku7s0a.betadots.training", "guxndq10.betadots.training", "gvy8hvhk.betadots.training", "gwcu2v40.betadots.training", "h9nn849h.betadots.training", "hmpbc41u.betadots.training", "hs5wnjha.betadots.training", "i82jmcn4.betadots.training", "iithv1y6.betadots.training", "j0dg6jl7.betadots.training", "j114trpy.betadots.training", "j6kant58.betadots.training", "j6p3emfi.betadots.training", "jb07smoq.betadots.training", "jlua9syg.betadots.training", "jo9ilwl3.betadots.training", "jxicx59k.betadots.training", "k81f2z6y.betadots.training", "kgx0whxs.betadots.training", "km2gee9p.betadots.training", "knbenvbp.betadots.training", "l8y7q7tv.betadots.training", "lj12xrpa.betadots.training", "lj8k5ad6.betadots.training", "lnlys2fc.betadots.training", "loi6f5y5.betadots.training", "lqytqz41.betadots.training", "lxb5xqrm.betadots.training", "m5rba5bj.betadots.training", "md55vdpb.betadots.training", "mlctzqgu.betadots.training", "mlr2pox0.betadots.training", "msttkvy6.betadots.training", "mtbwtip0.betadots.training", "nb9ljs79.betadots.training", "ndioaov6.betadots.training", "nk2gezhe.betadots.training", "o4gphsam.betadots.training", "on7fexx2.betadots.training", "oxnhoxvy.betadots.training", "pf3p6pcl.betadots.training", "qcmidm7d.betadots.training", "qeg3uvik.betadots.training", "qf3mu190.betadots.training", "qlc3fm46.betadots.training", "r48j23ne.betadots.training", "r6yzgkef.betadots.training", "r7khozne.betadots.training", "s3hhgc1r.betadots.training", "se3wo5kb.betadots.training", "skwdot22.betadots.training", "sse8epsu.betadots.training", "t7lfr3lc.betadots.training", "tdh4p6ix.betadots.training", "test.host", "testhost", "testhost2", "testhost3", "tgsy3idb.betadots.training", "tkytukvc.betadots.training", "tpebg47f.betadots.training", "u4u2iilk.betadots.training", "uai7e89l.betadots.training", "uswpm0lf.betadots.training", "vo0zsyto.betadots.training", "vvo59e81.betadots.training", "x5z92y7t.betadots.training", "xct89zsu.betadots.training", "xda8efsx.betadots.training", "xjh5gpa8.betadots.training", "xq9xpbvv.betadots.training", "xwjwyd98.betadots.training", "y7tifexf.betadots.training", "yrlqzaph.betadots.training", "yy4dijk2.betadots.training", "yzeqs4p0.betadots.training", "z36n2b2w.betadots.training", "zf2l0dws.betadots.training", "zp0zr62m.betadots.training"], Node.all_names(environment: "development").sort
  end

  test "create node object" do
    assert Node.new(hostname: 'testhost', environment: "development")
  end

  test "two nodes are equal when their hostnames and environments are identical" do
    node_one = Node.new(hostname: "testhost", environment: "development")
    node_two = Node.new(hostname: "testhost", environment: "development")
    assert_equal node_one, node_two
  end

  test "two nodes are not equal when they have different hostnames" do
    node_one = Node.new(hostname: "testhost", environment: "development")
    node_two = Node.new(hostname: "testhost2", environment: "development")
    assert_not_equal node_one, node_two
  end

  test "two nodes are not equal when they have different environments" do
    node_one = Node.new(hostname: "testhost", environment: "development")
    node_two = Node.new(hostname: "testhost", environment: "test")
    assert_not_equal node_one, node_two
  end

  test "check facts" do
    node = Node.new(hostname: 'testhost', environment: "development")
    expected_facts = {
      "fqdn"=>"testhost",
      "role"=>"hdm_test",
      "env"=>"development",
      "zone"=>"internal",
      "os"=>{"family"=>"RedHat"},
      "organization"=>"internal"
    }
    assert_equal expected_facts, node.facts
  end

  test "#to_param should return the hostname" do
    node = Node.new(hostname: "testhost", environment: "development")
    assert_equal "testhost", node.to_param
  end

  test "#to_s should return the hostname" do
    node = Node.new(hostname: "testhost", environment: "development")
    assert_equal "testhost", node.to_s
  end
end
