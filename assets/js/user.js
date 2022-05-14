import 'jquery';
import 'bootstrap';
import 'bootstrap-select';
import 'jquery-cropper';
import ProfileImage from './profile_image';
import LocationSelect from './location';
import 'cropperjs/dist/cropper.min.css';
import 'bootstrap/dist/css/bootstrap.min.css';
import 'bootstrap-select/dist/css/bootstrap-select.min.css';

const $countrySelect = $('#profile_form_country');

if ($countrySelect.length) {
    const $regionSelect = $('#profile_form_region');
    const $citySelect = $('#profile_form_city');
    const $regionLabel = $("label[for='profile_form_region']");
    const $countryLabel = $("label[for='profile_form_city']");

    const $countryId = $countrySelect.val();
    const $cityId = $('#cityId').attr('value');
    const $regionId = $('#regionId').attr('value');


    console.log("Country ID is " + $countryId);
    console.log("City ID is " + $cityId);
    console.log("Region ID is " + $regionId);

    new LocationSelect(
        $countryId,
        $regionId,
        $cityId,
        $countrySelect,
        $regionSelect,
        $citySelect,
        $regionLabel,
        $countryLabel,
        "Error fetching regions.",
        "Error fetch cities.");
}

const $image = $('#image');
if ($image.length) {
    console.log('Image is present');
    const $inputImageButton = $('#inputImageButton');
    const $URL = window.URL || window.webkitURL;
    let $blobURL;

    if ($URL) {
        $inputImageButton.change(function () {
            let $files = this.files;
            let $file;

            if (!$image.data('cropper')) {
                return;
            }

            if ($files && $files.length) {
                $file = $files[0];

                if (/^image\/\w+$/.test($file.type)) {
                    $blobURL = $URL.createObjectURL($file);
                    $image.one('built.cropper', function () {

                        // Revoke when load complete
                        $URL.revokeObjectURL($blobURL);
                    }).cropper('reset').cropper('replace', $blobURL);
                    $inputImageButton.val('');
                } else {
                    window.alert('Please choose an image $file.');
                }
            }
        });
    } else {
        $inputImageButton.prop('disabled', true).parent().addClass('disabled');
    }

    // Upload cropped image to server if the browser supports `HTMLCanvasElement.toBlob`
    new ProfileImage(
        $image,
        $('#uploadImageButton'),
        $("meta[name='_csrf']").attr("content"),
        $('#zoomInButton'),
        $('#zoomOutButton'),
        $('#rotateButton'),
        $('#profileImageSuccessMessage'),
        $('#profileImageFailureMessage')
    );
}

