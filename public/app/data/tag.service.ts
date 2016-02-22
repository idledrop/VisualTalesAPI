import {Injectable} from 'angular2/core';
import {Observable} from 'rxjs/Observable';

import {VisualTalesHttpService} from './data';

@Injectable()
export class TagService {
  constructor(private _visualTalesHttp:VisualTalesHttpService<ITag>) {
    this._visualTalesHttp.setUrl('tags');
  }

  getTags(tagName=''):Observable<ITag[]>{
    let params:any = {};
    
    if(tagName.length > 0){
      params.query = tagName;
    }
    
    return this._visualTalesHttp.getAll(params);
  }
  
  createTag(tag:ITag){
    return this._visualTalesHttp.create(tag);
  }
}

export interface ITag{
  id?:number;
  name:string;
}
