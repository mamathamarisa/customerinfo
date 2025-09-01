const cds=require('@sap/cds');
const {results} =  require ('@sap/cds/lib/utils/cds-utils');
 class CustomerService extends cds.ApplicationService{
  init(){
   const { Products , Customers } = this.entities;//to get reference of the entities in this service
     this.after('READ', Products , (results, req) =>{
     //debugger;
       let data = results.map((item =>{// arrow function with call back here item is indes=x 
           item.quantity =100;// for all the records it will add quantity field with value 100 for all records after readind
           return item;//from http file
       }));
       return req.data =data;
     });
     this.before('UPDATE' ,'Customers.drafts', (req)=>{
        //debugger;
        const { email } =req.data;
        if( !email.includes ('@')){
            req.error( 400,'Invalid Email Format');//from UI
        }
     });
    this.on('OrderStatus', async(req)=> {
      console.log("Action Invokde");
      let { ID } = req.data;
      let { Orders } = this.entities;//from ui
      if(req.data){
          var data = await UPDATE (Orders, ID).with ({
            OrderStatus_code: '02'
          });
        if(data){
          req.info(202, "Status Updated Successfully");
        }else{
          req.error(400, "unable to update status");
        }
       }      
    });
    this.before('Update' , 'Orders.drafts', async(req)=>{
      const { product_ID }= req.data;
      const{ Products } = this.entities;/// for side effetcs example to pre populate value of one field based on another field value to UI

      If (product_ID){
        let data = await SELECT.one.from(Products, product_ID);
        if(data){
        return req.data.orderType = data.type;
        }
      }
    });
    this.on('READ' , 'Employee' , async(req,res) =>{/// while reading if rovided in re means it will give that record else will give first2 records
      let{ Employee } =this.entities;
      let result=[];
      let wherecondition = req.data;
      if(wherecondition.hasOwnProperty("ID")){
        result = await cds.tx(req).run(SELECT.from (Employee).where(wherecondition));//loading request in trasaction
      }else{
         result =  await cds.tx(req).run(SELECT.from(Employee).limit(2));
      }
      return result;//from http 
    });
    this.on('UPDATE', 'Employeesrv' , async(req,res)=>{
      let{Employeesrv} =this.entities;
      let returnData =await cds.tx(req).run([
         UPDATE(Employeesrv).set({
          "firstName" : req.data.firstName
         }).where({
             ID:req.data.ID
         }),
         UPDATE(Employeesrv).set({
          "lastName" : req.data.lastName
         }).where({
          ID:req.data.ID
         })
      ]).then((resolve,reject) => {
           if(typeof(resolve)!== undefined){
            return req.data;
           }else{
             req.data(500,"there was an issues in update")
           }
      }).catch(err=>{
         req.data(500,"there was an error" +err.tostring());
      })
    })

    return super.init()//will retrun init method automatically to module.exports
  }


 }
 module.exports = CustomerService;
