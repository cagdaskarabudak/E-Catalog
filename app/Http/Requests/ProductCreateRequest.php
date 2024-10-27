<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class ProductCreateRequest extends FormRequest
{
    public function rules(): array
    {
        return [
            'name' => ['required', 'string', 'min:3', 'max:255'],
            'description' => ['required', 'string', 'min:20'],
            'retail_price' => ['required', 'integer', 'min:1', 'min:1'],
            'wholesale_prices' => ['required', 'array', 'min:1'],
            'images' => ['required', 'array', 'min:1'],
            'categories' => ['required', 'array', 'min:1'],
        ];
    }

    public function messages(): array
    {
        return [
            'name.required' => 'Ürün adı zorunludur.',
            'name.min' => 'Ürün adı en az :min karakter olmalıdır.',
            'description.required' => 'Ürün açıklaması zorunludur.',
            'description.min' => 'Ürün açıklaması en az :min karakter olmalıdır.',
            'retail_price.required' => 'Perakende fiyatı zorunludur.',
            'retail_price.integer' => 'Perakende fiyatı tam sayı olmalıdır.',
            'retail_price.min' => 'Perakende fiyatı :min\'den büyük olmalıdır.',
            'wholesale_prices.required' => 'En az bir toptan fiyat girmelisiniz.',
            'wholesale_prices.*.array' => 'Toptan fiyat formatı geçersiz.',
            'images.required' => 'En az bir resim yüklemeniz gerekmektedir.',
            'categories.required' => 'En az bir kategori seçmelisiniz.',
        ];
    }
}
