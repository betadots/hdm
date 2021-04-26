require 'test_helper'

class NodeTest < ActiveSupport::TestCase
  test "list the nodes" do
    assert_equal ["1m73otky.example42.training", "1tge1wo3.example42.training", "2288jh8e.example42.training", "33amc5da.example42.training", "3ay66ymd.example42.training", "3bx5fygw.example42.training", "3i8rrqjx.example42.training", "3io2n5uh.example42.training", "3q8ync63.example42.training", "40sbev55.example42.training", "4eexoda7.example42.training", "4jjfyx1h.example42.training", "5gfpx2k7.example42.training", "5gv8l8n3.example42.training", "5npv7v50.example42.training", "5ruwuuad.example42.training", "6mlkoauf.example42.training", "724pbcao.example42.training", "7jb746rk.example42.training", "7wdm4xss.example42.training", "8byzjpzz.example42.training", "8drk73w4.example42.training", "8yfl7kiv.example42.training", "9cvpd0wq.example42.training", "a2st4ipx.example42.training", "arbpv4us.example42.training", "arcnlzkm.example42.training", "b3pcqavv.example42.training", "b4739ubj.example42.training", "bzuvus9e.example42.training", "cn32iom0.example42.training", "cuar01ep.example42.training", "dbrn3h2r.example42.training", "dhplrtv.example42.training", "dmk15880.example42.training", "dmpp0nom.example42.training", "e5ujans9.example42.training", "eerukb8k.example42.training", "eztmlf24.example42.training", "fefo79a7.example42.training", "fj2yfmw.example42.training", "fnp4tnay.example42.training", "g39gaasx.example42.training", "gki2r2ip.example42.training", "gtlhhexp.example42.training", "guku7s0a.example42.training", "guxndq10.example42.training", "gvy8hvhk.example42.training", "gwcu2v40.example42.training", "h9nn849h.example42.training", "hmpbc41u.example42.training", "hs5wnjha.example42.training", "i82jmcn4.example42.training", "iithv1y6.example42.training", "j0dg6jl7.example42.training", "j114trpy.example42.training", "j6kant58.example42.training", "j6p3emfi.example42.training", "jb07smoq.example42.training", "jlua9syg.example42.training", "jo9ilwl3.example42.training", "jxicx59k.example42.training", "k81f2z6y.example42.training", "kgx0whxs.example42.training", "km2gee9p.example42.training", "knbenvbp.example42.training", "l8y7q7tv.example42.training", "lj12xrpa.example42.training", "lj8k5ad6.example42.training", "lnlys2fc.example42.training", "loi6f5y5.example42.training", "lqytqz41.example42.training", "lxb5xqrm.example42.training", "m5rba5bj.example42.training", "md55vdpb.example42.training", "mlctzqgu.example42.training", "mlr2pox0.example42.training", "msttkvy6.example42.training", "mtbwtip0.example42.training", "nb9ljs79.example42.training", "ndioaov6.example42.training", "nk2gezhe.example42.training", "o4gphsam.example42.training", "on7fexx2.example42.training", "oxnhoxvy.example42.training", "pf3p6pcl.example42.training", "qcmidm7d.example42.training", "qeg3uvik.example42.training", "qf3mu190.example42.training", "qlc3fm46.example42.training", "r48j23ne.example42.training", "r6yzgkef.example42.training", "r7khozne.example42.training", "s3hhgc1r.example42.training", "se3wo5kb.example42.training", "skwdot22.example42.training", "sse8epsu.example42.training", "t7lfr3lc.example42.training", "tdh4p6ix.example42.training", "test.host", "testhost", "testhost2", "testhost3", "tgsy3idb.example42.training", "tkytukvc.example42.training", "tpebg47f.example42.training", "u4u2iilk.example42.training", "uai7e89l.example42.training", "uswpm0lf.example42.training", "vo0zsyto.example42.training", "vvo59e81.example42.training", "x5z92y7t.example42.training", "xct89zsu.example42.training", "xda8efsx.example42.training", "xjh5gpa8.example42.training", "xq9xpbvv.example42.training", "xwjwyd98.example42.training", "y7tifexf.example42.training", "yrlqzaph.example42.training", "yy4dijk2.example42.training", "yzeqs4p0.example42.training", "z36n2b2w.example42.training", "zf2l0dws.example42.training", "zp0zr62m.example42.training"], Node.all_names.sort
  end

  test "create node object" do
    assert Node.new('testhost')
  end

  test "raise error for non existing nodes" do
    err = assert_raises(Node::NotFound) { Node.new('unknown') }
    assert_match("Node 'unknown' does not exist", err.message)
  end

  test "do not raise error when skipping validation" do
    assert_nothing_raised do
      Node.new("unknown", skip_validation: true)
    end
  end

  test "two nodes are equal when their hostnames are identical" do
    node_one = Node.new("testhost")
    node_two = Node.new("testhost")
    assert_equal node_one, node_two
  end

  test "two nodes are not equal when they have different hostnames" do
    node_one = Node.new("testhost")
    node_two = Node.new("testhost2")
    assert_not_equal node_one, node_two
  end

  test "check facts" do
    node = Node.new('testhost')
    expected_facts = {
      "fqdn"=>"testhost",
      "role"=>"hdm_test",
      "env"=>"development",
      "zone"=>"internal",
      "os"=>{"family"=>"RedHat"},
      "organization"=>"internal"
    }
    assert_equal expected_facts, node.facts(environment: "development")
  end

  test "#to_param should return the hostname" do
    node = Node.new("testhost")
    assert_equal "testhost", node.to_param
  end

  test "#to_s should return the hostname" do
    node = Node.new("testhost")
    assert_equal "testhost", node.to_s
  end
end
