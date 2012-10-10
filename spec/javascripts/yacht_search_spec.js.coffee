describe("Deserialize data Filter yacht", function () {
  it("get null values from deserializeFilter", function() {
    var hash = '#filter?{"hulls":[],"marinas":[],"models":[],"min_cabins":null,"max_age":null,"min_length":null}'
    var result =  yl.search.deserializeFilter(hash)
    expect(result).toEqual(null)
  });
  
  it("get all values from search parameters with deserializeFilter", function() {
    var hash = '#filter={"hulls":["mono"],"marinas":["Murter / Betina","Murter / Jezera","Porec"],"models":["Bavaria 31 Cruiser", "Bavaria 38 Cruiser", "Bavaria 38 Cruiser Deluxe"],"min_cabins":57,"max_age":6,"min_length":3}'
    var result =  yl.search.deserializeFilter(hash)
    expect(result['hulls']).toEqual(["mono"])
    expect(result['marinas']).toEqual(["Murter / Betina","Murter / Jezera","Porec"])
    expect(result['models']).toEqual(["Bavaria 31 Cruiser", "Bavaria 38 Cruiser", "Bavaria 38 Cruiser Deluxe"])
    expect(result['min_cabins']).toEqual(57)
    expect(result['max_age']).toEqual(6)
    expect(result['min_length']).toEqual(3)
  });
});

describe("Return data for filter form", function () {
  it("should return data from fixtures to filter form", function() {
    loadFixtures("yachts.html");
    
    yl.search.bindFilter()
    expect($('#search-filter-form select[name=length]').val()).toEqual('38')
    expect($('#search-filter-form select[name=cabins]').val()).toEqual('3')
    expect($('#search-filter-form select[name=age]').val()).toEqual('3')
    expect($('#search-filter-form select[name=length] option').length).toEqual(8)
    expect($('#search-filter-form select[name=cabins] option').length).toEqual(4)
    expect($('#search-filter-form select[name=age] option').length).toEqual(3)
    expect($('#search-filter-form input[name=hull\\[\\]]:checked').val()).toEqual('mono')
    expect($('#search-filter-form input[name=marina\\[\\]]:checked').val()).toEqual('Kastela')
    expect($('#search-filter-form input[name=model\\[\\]]:checked').val()).toEqual('Bavaria 38 Cruiser')
    
  });
});

describe("Searching yacht base on the fixtures", function () {
  it("Should return all filter fields", function() {
    loadFixtures("yachts.html");
    
    var result = yl.search.getFilter()
    expect(result["hulls"]).toContain('mono')
    expect(result["marinas"]).toContain('Porec')
    expect(result["models"]).toContain('Bavaria 38 Cruiser')
    expect(result["min_cabins"]).toEqual(3)
    expect(result["max_age"]).toEqual(1)
    expect(result["min_length"]).toEqual(38)
  });
});


describe("Check the filter result", function () {
  it("should return valid yacht", function(){
    loadFixtures("yachts.html");
    
    var result = $("article.yacht");
    var first_result = $("article.yacht").first();
    var first_result_desc = $("div.yacht-detail p", first_result).html();
    var first_result_model_and_price = $("div.yacht-detail h3", first_result).html();
    var first_result_hull = $("div.yacht-type", first_result).html().trim()
    var first_result_length = $("div.yacht-spec li", first_result).first().html()
    var first_result_toilet = $("div.yacht-spec li", first_result).eq(1).html()
    var first_result_cabin = $("div.yacht-spec li", first_result).eq(2).html()
    var first_result_bed = $("div.yacht-spec li", first_result).eq(3).html()
    var first_result_year = $("div.yacht-spec li", first_result).eq(4).html()
  
    expect($("article.yacht").size()).toEqual(3);
    expect(first_result_desc).toEqual('An amazing family boat the takes the waves with awe!');
    expect(first_result_model_and_price).toEqual('Bavaria 38 Cruiser €3000');
    expect(first_result_hull).toEqual('mono');
    expect(first_result_length).toEqual('38ft');
    expect(first_result_toilet).toEqual('1 toilets');
    expect(first_result_cabin).toEqual('3 cabins');
    expect(first_result_bed).toEqual('6 beds');
    expect(first_result_year).toEqual('2009');
  });
});
describe("Filter yacht with options", function () {
  it("should hide yacths if hull mono is unchecked", function(){
    loadFixtures("yacht-search.html");
    $('#search-filter-form input[name=hull\\[\\]]').removeAttr('checked');
    yl.search.filterBoats()

    var first_yacht = $("article.yacht").first();
    var second_yacht = $("article.yacht").eq(1);
    var third_yacht = $("article.yacht").eq(2);
    expect(first_yacht.css('display')).toEqual('none');
    expect(second_yacht.css('display')).toEqual('none');
    expect(third_yacht.css('display')).toEqual('none');
  });
  
  it("should hide yacths in Porec Marina if Porec unchecked", function(){
    loadFixtures("yacht-search.html");
    $('#search-filter-form input[name=marina\\[\\]][value="Porec"]').attr('checked', false);
    yl.search.filterBoats()

    
    var first_yacht = $("article.yacht").first();
    var second_yacht = $("article.yacht").eq(1);
    var third_yacht = $("article.yacht").eq(2);

    expect(first_yacht.css('display')).toEqual('block');
    expect(second_yacht.css('display')).toEqual('block');
    expect(third_yacht.css('display')).toEqual('none');

  });

  it("should hide yacths in Kastela Marina if Kastela unchecked", function(){
    loadFixtures("yacht-search.html");
    $('#search-filter-form input[value="Kastela"]').attr('checked', false);
    yl.search.filterBoats()

    var first_yacht = $("article.yacht").first();
    var second_yacht = $("article.yacht").eq(1);
    var third_yacht = $("article.yacht").eq(2);
    expect(first_yacht.css('display')).toEqual('none');
    expect(second_yacht.css('display')).toEqual('none');
    expect(third_yacht.css('display')).toEqual('block');
  });
  
	it("should show yacths with 6 cabins if user select 6 in cabins dropdown", function(){
    loadFixtures("yachts.html");
    $('#search-filter-form select[name=cabins]').val('6');
    yl.search.filterBoats()
    
    first_yacht = $("article.yacht").first();
    second_yacht = $("article.yacht").eq(1);
    third_yacht = $("article.yacht").eq(2);
    expect(first_yacht.css('display')).toEqual('none');
    expect(second_yacht.css('display')).toEqual('block');
    expect(third_yacht.css('display')).toEqual('none');


		expect($("div.yacht-detail p", second_yacht).html()).toEqual('An amazing family boat the takes the waves with awe!');
		expect($("div.yacht-detail h3", second_yacht).html()).toEqual('Bavaria 38 Cruiser €2500');
		expect($("div.yacht-type", second_yacht).html().trim()).toEqual('mono');
		expect($("div.yacht-spec li", second_yacht).first().html()).toEqual('45ft');
		expect($("div.yacht-spec li", second_yacht).eq(1).html()).toEqual('1 toilets');
		expect($("div.yacht-spec li", second_yacht).eq(2).html()).toEqual('6 cabins');
		expect($("div.yacht-spec li", second_yacht).eq(3).html()).toEqual('6 beds');
		expect($("div.yacht-spec li", second_yacht).eq(4).html()).toEqual('2011');

  });
});