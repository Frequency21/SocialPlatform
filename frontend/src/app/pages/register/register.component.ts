import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { ImageService } from 'src/app/services/image.service';
import { UserService } from 'src/app/services/user.service';
import { User } from 'src/app/shared/models/user.model';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.scss']
})
export class RegisterComponent implements OnInit {

  public selectedFile?: File;
  public imgSrc?: string;

  form: FormGroup = new FormGroup({
    username: new FormControl(),
    email: new FormControl(),
    password1: new FormControl(),
    password2: new FormControl()
  });

  constructor(private imageService: ImageService) { }

  ngOnInit(): void { }

  registration(): void {
    let formData = new FormData();

    formData.set('file', this.selectedFile as Blob, this.selectedFile?.name);
    this.imageService.uploadImage(formData).subscribe(
      res => {
        this.imgSrc = res;
      }
    );

  }

  onSelectFile(event: any) {
    this.selectedFile = event.target.files[event.target.files.length - 1] as File;
  }

}
