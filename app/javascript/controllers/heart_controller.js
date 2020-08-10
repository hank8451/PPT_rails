import { Controller } from "stimulus"
// import ax from "axios";
import Rails from "@rails/ujs";


export default class extends Controller {
  static targets = ["heart"]
  // let that = this;

  favorite() {

    let board_id = this.data.get("board");
  //   // const token = document.querySelector("meta[name=csrf-token]").content;
  //   // console.log(token);
  //   // ax.defaults.headers.common['X-CSRF-Token'] = token;
    Rails.ajax({
      url: `/boards/${board_id}/favorite.json`,
      type: 'post',
      success: (result) => {
        if (result["status"] == true){
          this.heartTarget.classList.remove("far");
          this.heartTarget.classList.add("fas");
        } else {
          this.heartTarget.classList.remove("fas");
          this.heartTarget.classList.add("far");
        }
      },
      error: (err) => {
        console.log(err);
      }
    })
  // );
  //   ax.post(`/boards/${board_id}/favorite.json`)
  //     .then(result =>{
  //       if (result.data["status"]==true){
  //         this.heartTarget.classList.remove("far");
  //         this.heartTarget.classList.add("fas");
  //       }else {
  //         this.heartTarget.classList.remove("fas");
  //         this.heartTarget.classList.add("far");
  //       }
  //       console.log(result);
  //     })
  //     .catch(function(err){
  //       console.log(err);
  //     })
  }     
}