import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ModalPosztComponent } from './modal-poszt.component';

describe('ModalPosztComponent', () => {
  let component: ModalPosztComponent;
  let fixture: ComponentFixture<ModalPosztComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ModalPosztComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(ModalPosztComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
