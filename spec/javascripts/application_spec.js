describe("Marina Autocomplete", function(){
   var testdata = 'Kastela'
       beforeEach(function() {});

       it("should call autocomplete and return marina",function() {

           spyOn($.fn, 'autocomplete').andReturn(testdata);
           $('#search-form #destination').autocomplete('Kastela');
           expect($.fn.autocomplete).toHaveBeenCalledWith(testdata);

       });
       
       it("should call autocomplete and not return marina",function() {

            spyOn($.fn, 'autocomplete').andReturn(testdata);
            $('#search-form #destination').autocomplete('Croatia');
            expect($.fn.autocomplete).not.toHaveBeenCalledWith(testdata);

        });
});

